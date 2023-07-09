//
//  MoviesInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

protocol MoviesBusinessLogic: AnyObject {
    func fetchNowPlaying()
    func selectMovieDetail(index: Int)
}

protocol MoviesDataStore: AnyObject {
    var selectedMovieId: Int? { get set }
    var movieResponse: [MoviesResponse.Movie] { get set }
}

final class MoviesInteractor: MoviesBusinessLogic, MoviesDataStore {
    var presenter: MoviesPresentationLogic?
    var worker: MoviesWorkingLogic = MoviesWorker()
    
    var selectedMovieId: Int?
    var movieResponse: [MoviesResponse.Movie] = []
    
    func fetchNowPlaying() {
        worker.getNowPlaying { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                self.movieResponse = response.results
                let response = MoviesModels.FetchMovies.Response(movies: response.results)
                self.presenter?.presentMovies(response: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func selectMovieDetail(index: Int) {
        selectedMovieId = movieResponse[index].id
        presenter?.presentMovieDetail()
    }
}
