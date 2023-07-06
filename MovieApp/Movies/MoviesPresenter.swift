//
//  MoviesPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

protocol MoviesPresentationLogic: AnyObject {
    func presentMovies(response: MoviesModels.FetchMovies.Response)
    func presentMovieDetail()
//    func presentDetails(response: MovieDetailsModels.FetchMovieDetails.Response2)
}

final class MoviesPresenter: MoviesPresentationLogic {
    
    weak var viewController: MoviesDisplayLogic?
    
    func presentMovies(response: MoviesModels.FetchMovies.Response) {
        
        var displayedMovies: [MoviesModels.FetchMovies.ViewModel.DisplayedMovie] = []
        
        response.movies.forEach {
            displayedMovies.append(MoviesModels.FetchMovies.ViewModel.DisplayedMovie(
                title: $0.title,
                releaseDate: $0.releaseDate,
                posterPath: $0.posterPath,
                vote: $0.vote,
                id: $0.id
            )
            )
        }
        
        let viewModel = MoviesModels.FetchMovies.ViewModel(displayedMovies: displayedMovies)
        DispatchQueue.main.async {
            self.viewController?.displayFetchedMovies(viewModel: viewModel)
        }
    }
    
    func presentMovieDetail() {
        viewController?.displayMovieDetails()
    }
    
//    func presentDetails(response: MovieDetailsModels.FetchMovieDetails.Response2) {
//        let displayedDetails = MoviesModels.FetchMovies.ViewModel2.DisplayedDetails(
//            runtime: response.details.runtime
//        )
//
//        DispatchQueue.main.async {
//            self.viewController?.displayFetchedDetails(viewModel: displayedDetails)
//        }
//    }
}
