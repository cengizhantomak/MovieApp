//
//  PaymentPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 15.07.2023.
//

import Foundation

protocol PaymentPresentationLogic: AnyObject {
    func presentMovie(_ displayedTitle: String, _ displayedImage: String, _ displayedDate: String, _ displayedTheatre: String, _ displayedSeat: [String], _ displayedPrice: Double)
}

final class PaymentPresenter: PaymentPresentationLogic {
    
    weak var viewController: PaymentDisplayLogic?
    
    func presentMovie(_ displayedTitle: String, _ displayedImage: String, _ displayedDate: String, _ displayedTheatre: String, _ displayedSeat: [String], _ displayedPrice: Double) {
        let displayedMovie = PaymentModels.FetchPayment.ViewModel(
            selectedMovieTitle: displayedTitle,
            selectedMovieImage: displayedImage,
            selectedDate: displayedDate,
            selectedTheater: displayedTheatre,
            chooseSeat: displayedSeat.joined(separator: ", "),
            totalAmount: displayedPrice
        )
        
        self.viewController?.displayFetchedMovie(viewModel: displayedMovie)
    }
}
