//
//  MovieDetailsInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

protocol MovieDetailsBusinessLogic: AnyObject {
    func fetchMovieNames()
}

protocol MovieDetailsDataStore: AnyObject {
    var movieID: Int? { get set }
}

final class MovieDetailsInteractor: MovieDetailsBusinessLogic, MovieDetailsDataStore {
    
    var presenter: MovieDetailsPresentationLogic?
    var worker: MovieDetailsWorkingLogic = MovieDetailsWorker()
    
    var movieID: Int?
    func fetchMovieNames() {
        
        guard let id = movieID else { return }
        
        worker.getMovieCredits(id: id) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let credits):
                let response = MovieDetailsModels.FetchNames.Response(names: credits.cast)
                self.presenter?.presentNames(response: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        worker.getMovieDetails(id: id) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let details):
                let response = MovieDetailsModels.FetchNames.Response2(details: details)
                self.presenter?.presentDetails(response: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}
