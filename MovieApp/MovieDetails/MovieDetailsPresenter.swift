//
//  MovieDetailsPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

protocol MovieDetailsPresentationLogic: AnyObject {
    func presentNames(response: MovieDetailsModels.FetchNames.Response)
    func presentDetails(response: MovieDetailsModels.FetchNames.Response2)
}

final class MovieDetailsPresenter: MovieDetailsPresentationLogic {
    
    weak var viewController: MovieDetailsDisplayLogic?
    
    func presentNames(response: MovieDetailsModels.FetchNames.Response) {
        let displayedCast = response.names.map {
            MovieDetailsModels.FetchNames.ViewModel.DisplayedCast(
                name: $0.name ?? "",
                character: $0.character ?? "",
                profilePath: $0.profilePath ?? ""
            )
        }
        let viewModel = MovieDetailsModels.FetchNames.ViewModel(displayedCast: displayedCast)
        
        DispatchQueue.main.async {
            self.viewController?.displayFetchedNames(viewModel: viewModel)
        }
    }
    
    func presentDetails(response: MovieDetailsModels.FetchNames.Response2) {
        let displayedDetails = MovieDetailsModels.FetchNames.ViewModel2.DisplayedDetails(
            title: response.details.title,
            overview: response.details.overview,
            genres: response.details.genres.map { $0.genresName }.joined(separator: ", "),
            runtime: response.details.runtime,
            vote: response.details.vote,
            posterPath: response.details.posterPath
        )
        
        DispatchQueue.main.async {
            self.viewController?.displayFetchedDetails(viewModel: displayedDetails)
        }
    }
}
