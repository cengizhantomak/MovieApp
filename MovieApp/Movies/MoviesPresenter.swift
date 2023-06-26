//
//  MoviesPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

protocol MoviesPresentationLogic: AnyObject {
    func presentMovies(response: MoviesModels.FetchMovies.Response)
}

final class MoviesPresenter: MoviesPresentationLogic {
    
    weak var viewController: MoviesDisplayLogic?
    
    func presentMovies(response: MoviesModels.FetchMovies.Response) {
        
        var displayedMovies: [MoviesModels.FetchMovies.ViewModel.DisplayedMovie] = []
        
        response.movies.forEach {
            displayedMovies.append(MoviesModels.FetchMovies.ViewModel.DisplayedMovie(title: $0.title))
        }
        
//        for movie in response.movies {
//            let displayedMovie = MoviesModels.FetchMovies.ViewModel.DisplayedMovie(title: movie.title)
//            displayedMovies.append(displayedMovie)
//        }
        let viewModel = MoviesModels.FetchMovies.ViewModel(displayedMovies: displayedMovies)
        DispatchQueue.main.async {
            self.viewController?.displayFetchedMovies(viewModel: viewModel)
        }
//        viewController?.displayFetchedMovies(viewModel: .init(displayedMovies: displayedMovies))
    }
}
