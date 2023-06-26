//
//  MoviesInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

protocol MoviesBusinessLogic: AnyObject {
    func fetchTopRatedMovies()
}

protocol MoviesDataStore: AnyObject {
    
}

final class MoviesInteractor: MoviesBusinessLogic, MoviesDataStore {
    
    var presenter: MoviesPresentationLogic?
    var worker: MoviesWorkingLogic = MoviesWorker()
    
    func fetchTopRatedMovies() {
        worker.getTopRatedMovies { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let topRatedMovies):
                let response = MoviesModels.FetchMovies.Response(movies: topRatedMovies.results)
                self.presenter?.presentMovies(response: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
