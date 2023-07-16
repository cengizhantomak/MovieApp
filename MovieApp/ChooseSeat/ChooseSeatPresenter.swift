//
//  ChooseSeatPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 14.07.2023.
//

import Foundation

protocol ChooseSeatPresentationLogic: AnyObject {
    func presentMovie(_ displayedTitle: String, _ displayedImage: String, _ displayedDate: String, _ displayedTheatre: String)
    func presentSeatPrice()
}

final class ChooseSeatPresenter: ChooseSeatPresentationLogic {
    
    weak var viewController: ChooseSeatDisplayLogic?
    
    func presentMovie(_ displayedTitle: String, _ displayedImage: String, _ displayedDate: String, _ displayedTheatre: String) {
        let displayedMovie = ChooseSeatModels.FetchChooseSeat.ViewModel(
            selectedMovieTitle: displayedTitle,
            selectedMovieImage: displayedImage,
            selectedDate: displayedDate,
            selectedTheater: displayedTheatre
        )
        
        self.viewController?.displayFetchedMovie(viewModel: displayedMovie)
    }
    
    func presentSeatPrice() {
        viewController?.displaySeatPrice()
    }
}
