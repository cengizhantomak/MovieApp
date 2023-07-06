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
}

protocol MovieDetailsDataStore: AnyObject {
    var selectedMovieID: Int? { get set }
    var allCast: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedCast] { get set }
    var allPhotos: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedImages] { get set }
}

final class MovieDetailsInteractor: MovieDetailsBusinessLogic, MovieDetailsDataStore {
    
    var presenter: MovieDetailsPresentationLogic?
    var worker: MovieDetailsWorkingLogic = MovieDetailsWorker()
    
    var selectedMovieID: Int?
    var allCast: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedCast] = []
    var allPhotos: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedImages] = []
    
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
    
    func fetchMovieCast(details: MoviesResponse.MovieDetail.Movie) {
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
    
    func fetchmovieImages(details: MoviesResponse.MovieDetail.Movie, cast: [MoviesResponse.MovieCredits.Cast]) {
        guard let id = selectedMovieID else { return }
        worker.getMovieImages(id: id) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let images):
                let response = MovieDetailsModels.FetchMovieDetails.Response(cast: cast, details: details, images: images.backdrops)
                self.presenter?.presentDetails(response: response)
            case .failure(let error):
                print(error.localizedDescription)
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
}
