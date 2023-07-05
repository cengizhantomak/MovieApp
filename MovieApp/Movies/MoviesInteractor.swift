//
//  MoviesInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

protocol MoviesBusinessLogic: AnyObject {
    func fetchNowPlaying()
//    func fetchMovieNames(id: Int)
}

protocol MoviesDataStore: AnyObject {
    var selectedMovieID: Int? { get set }
}

final class MoviesInteractor: MoviesBusinessLogic, MoviesDataStore {
    
    var selectedMovieID: Int?
    
    var presenter: MoviesPresentationLogic?
    var worker: MoviesWorkingLogic = MoviesWorker()
    
    func fetchNowPlaying() {
        worker.getNowPlaying { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let nowPlaying):
                let response = MoviesModels.FetchMovies.Response(movies: nowPlaying.results)
                self.presenter?.presentMovies(response: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    func fetchMovieNames(id: Int) {
////        guard let id = selectedMovieID else { return }
//
//        worker.getMovieDetails(id: id) { [weak self] result in
//            guard let self else { return }
//
//            switch result {
//            case .success(let details):
//                let response = MovieDetailsModels.FetchNames.Response2(details: details)
//                self.presenter?.presentDetails(response: response)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
}
