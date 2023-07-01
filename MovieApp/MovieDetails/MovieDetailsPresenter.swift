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
        
        var displayedNames: [MovieDetailsModels.FetchNames.ViewModel.DisplayedCast] = []
        
        response.names.forEach {
            displayedNames.append(MovieDetailsModels.FetchNames.ViewModel.DisplayedCast(name: $0.name ?? "", character: $0.character ?? "", profilePath: $0.profilePath ?? ""))
        }
        let viewModel = MovieDetailsModels.FetchNames.ViewModel(displayedCast: displayedNames)
        DispatchQueue.main.async {
            self.viewController?.displayFetchedNames(viewModel: viewModel)
        }
    }
    
    func presentDetails(response: MovieDetailsModels.FetchNames.Response2) {
        
//        var displayedDetails: [MovieDetailsModels.FetchNames.ViewModel2.DisplayedDetails] = []
        
        let title = response.details.title 
        let overview = response.details.overview
        let runtime = response.details.runtime
        let vote = response.details.vote
        let posterPath = response.details.posterPath
        let genres = response.details.genres.map { $0.genresName }.joined(separator: ", ")
        
//        let displayedDetail = MovieDetailsModels.FetchNames.ViewModel2.DisplayedDetails(title: title, overview: overview, genres: genres)//, genres: genres)
//        displayedDetails.append(displayedDetail)

        let viewModel = MovieDetailsModels.FetchNames.ViewModel2(title: title, overview: overview, genres: genres, runtime: runtime, vote: vote, posterPath: posterPath)
        DispatchQueue.main.async {
            self.viewController?.displayFetchedDetails(viewModel: viewModel)
        }
    }
    
}
