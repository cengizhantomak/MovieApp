//
//  MovieDetailsInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

protocol MovieDetailsBusinessLogic: AnyObject {
    func fetchMovieDetails()
    func viewAllCast(with: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedCast])
    func viewAllPhotos(with: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedImages])
    func postToAddWatchlist()
    func postToRemoveWatchlist()
    func selectedMovieGetTicket(movie: String, image: String)
    func formatRuntime(_ totalMinutes: Int) -> String
    func toggleWatchlistStatus(_ details: MovieDetailsModels.FetchMovieDetails.ViewModel?) -> MovieDetailsModels.FetchMovieDetails.ViewModel?
}

protocol MovieDetailsDataStore: AnyObject {
    var selectedMovieID: Int? { get set }
    var allCast: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedCast] { get set }
    var allPhotos: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedImages] { get set }
    var selectedMovieTitle: String? { get set }
    var selectedMovieImage: String? { get set }
}

final class MovieDetailsInteractor: MovieDetailsBusinessLogic, MovieDetailsDataStore {
    
    var presenter: MovieDetailsPresentationLogic?
    let httpClient = NetworkHTTPClient()
    var worker: MovieDetailsWorkingLogic = MovieDetailsWorker(httpClient: NetworkHTTPClient())
    
    var selectedMovieID: Int?
    var allCast: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedCast] = []
    var allPhotos: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedImages] = []
    var selectedMovieTitle: String?
    var selectedMovieImage: String?
    
    func fetchMovieDetails() {
        guard let id = selectedMovieID else { return }
        worker.getMovieDetails(id: id) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let details):
                fetchMovieCast(details: details)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchMovieCast(details: MoviesResponse.Movie) {
        guard let id = selectedMovieID else { return }
        
        worker.getMovieCredits(id: id) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let credits):
                fetchmovieImages(details: details, cast: credits.cast)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchmovieImages(details: MoviesResponse.Movie, cast: [MoviesResponse.Cast]) {
        guard let id = selectedMovieID else { return }
        worker.getMovieImages(id: id) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let images):
                fetchWatchList(details: details, cast: cast, images: images.backdrops)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchWatchList(details: MoviesResponse.Movie, cast: [MoviesResponse.Cast], images: [MoviesResponse.Images]) {
        worker.getWatchList { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let watchList):
                let response = MovieDetailsModels.FetchMovieDetails.Response(cast: cast, details: details, images: images, watchList: watchList.results)
                self.presenter?.presentDetails(response: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func postToAddWatchlist() {
        guard let id = selectedMovieID else { return }
        worker.postToAddWatchlist(movieId: id) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let response):
                print("Film başarıyla watchlist'e eklendi!: \(response)")
                NotificationCenter.default.post(name: .movieAddedToWatchlist, object: nil)
            case .failure(let error):
                print("Watchlist'e film eklenirken hata: \(error.localizedDescription)")
                NotificationCenter.default.post(name: .movieAddDeleteToWatchlistFailed, object: nil)
            }
        }
    }
    
    func postToRemoveWatchlist() {
        guard let id = selectedMovieID else { return }
        worker.postToRemoveWatchlist(movieId: id) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let response):
                print("Film başarıyla watchlist'ten silindi!: \(response)")
                NotificationCenter.default.post(name: .movieDeletedToWatchlist, object: nil)
            case .failure(let error):
                print("Watchlist'e film silinirken hata: \(error.localizedDescription)")
                NotificationCenter.default.post(name: .movieAddDeleteToWatchlistFailed, object: nil)
            }
        }
    }
    
    func viewAllCast(with: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedCast]) {
        allCast = with
        presenter?.presentAllCast()
    }
    
    func viewAllPhotos(with: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedImages]) {
        allPhotos = with
        presenter?.presentAllPhotos()
    }
    
    func selectedMovieGetTicket(movie: String, image: String) {
        selectedMovieTitle = movie
        selectedMovieImage = image
        presenter?.presentGetTicket()
    }
    
    func formatRuntime(_ totalMinutes: Int) -> String {
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return "\(hours)hr \(minutes)m"
    }
    
    func toggleWatchlistStatus(_ details: MovieDetailsModels.FetchMovieDetails.ViewModel?) -> MovieDetailsModels.FetchMovieDetails.ViewModel? {
        guard var displayedDetails = details else { return nil }

        if displayedDetails.displayedWatchList.contains(where: { $0.watchListId == displayedDetails.id }) {
            postToRemoveWatchlist()
            if let index = displayedDetails.displayedWatchList.firstIndex(where: { $0.watchListId == displayedDetails.id }) {
                displayedDetails.displayedWatchList.remove(at: index)
            }
        } else {
            postToAddWatchlist()
            let watchlistItem = MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedWatchList(watchListId: displayedDetails.id)
            displayedDetails.displayedWatchList.append(watchlistItem)
        }
        return displayedDetails
    }
}
