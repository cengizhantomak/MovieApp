//
//  MoviesInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

protocol MoviesBusinessLogic: AnyObject {
    func fetchNowPlaying()
    func selectMovieDetail(index: Int) //2. yöntem
}

protocol MoviesDataStore: AnyObject {
    var selectedMovieId: Int? { get set } //2. yöntem
    var movieResponse: [MoviesResponse.MovieNowPlaying.Movie] { get set } //2. yöntem
}

final class MoviesInteractor: MoviesBusinessLogic, MoviesDataStore {
    
    var selectedMovieId: Int? //2. yöntem
    
    var presenter: MoviesPresentationLogic?
    var worker: MoviesWorkingLogic = MoviesWorker()
    var movieResponse: [MoviesResponse.MovieNowPlaying.Movie] = [] //2. yöntem
    
    func fetchNowPlaying() {
        worker.getNowPlaying { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                self.movieResponse = response.results //2. yöntem
                let response = MoviesModels.FetchMovies.Response(movies: response.results)
                self.presenter?.presentMovies(response: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func selectMovieDetail(index: Int) { //2. yöntem
        
        selectedMovieId = movieResponse[index].id
        presenter?.presentMovieDetail()
    }
    
//    func fetchMovieNames(id: Int) {
////        guard let id = selectedMovieID else { return }
//
//        worker.getMovieDetails(id: id) { [weak self] result in
//            guard let self else { return }
//
//            switch result {
//            case .success(let details):
//                let response = MovieDetailsModels.FetchMovieDetails.Response2(details: details)
//                self.presenter?.presentDetails(response: response)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
}
