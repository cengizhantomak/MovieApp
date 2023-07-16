//
//  ChooseSeatPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 14.07.2023.
//

import Foundation

protocol ChooseSeatPresentationLogic: AnyObject {
    func presentMovie(seatDetails: ChooseSeatModels.FetchChooseSeat.ViewModel)
    func presentSeatPrice()
}

final class ChooseSeatPresenter: ChooseSeatPresentationLogic {
    
    weak var viewController: ChooseSeatDisplayLogic?
    
    func presentMovie(seatDetails: ChooseSeatModels.FetchChooseSeat.ViewModel) {
        self.viewController?.displayFetchedMovie(viewModel: seatDetails)
    }
    
    func presentSeatPrice() {
        viewController?.displaySeatPrice()
    }
}
