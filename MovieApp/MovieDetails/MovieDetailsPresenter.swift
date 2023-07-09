//
//  MovieDetailsPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

protocol MovieDetailsPresentationLogic: AnyObject {
    func presentDetails(response: MovieDetailsModels.FetchMovieDetails.Response)
    func presentCast(names: [MoviesResponse.Cast]) -> [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedCast]
    func presentImages(images: [MoviesResponse.Images]) -> [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedImages]
    func presentAllCast()
    func presentAllPhotos()
}

final class MovieDetailsPresenter: MovieDetailsPresentationLogic {
    
    weak var viewController: MovieDetailsDisplayLogic?
    
    func presentDetails(response: MovieDetailsModels.FetchMovieDetails.Response) {
        let displayedDetails = MovieDetailsModels.FetchMovieDetails.ViewModel(
            displayedCast: presentCast(names: response.cast), displayedImages: presentImages(images: response.images),
            title: response.details.title,
            overview: response.details.overview,
            genres: response.details.genres?.compactMap { $0.name }.joined(separator: ", ") ?? "",
            runtime: response.details.runtime ?? 0,
            vote: response.details.vote,
            posterPhotoPath: response.details.posterPath
        )
        
        DispatchQueue.main.async {
            self.viewController?.displayFetchedDetails(viewModel: displayedDetails)
        }
    }
    
    func presentCast(names: [MoviesResponse.Cast]) -> [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedCast] {
        return names.map {
            MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedCast(
                name: $0.name ?? "",
                character: $0.character ?? "",
                profilePhotoPath: $0.profilePhoto ?? ""
            )
        }
    }
    
    func presentImages(images: [MoviesResponse.Images]) -> [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedImages] {
        return images.map {
            MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedImages(
                images: $0.images
            )
        }
    }
    
    func presentAllCast() {
        viewController?.displayCast()
    }
    
    func presentAllPhotos() {
        viewController?.displayPhotos()
    }
}
