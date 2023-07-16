//
//  PaymentPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 15.07.2023.
//

import Foundation

protocol PaymentPresentationLogic: AnyObject {
    func presentMovie(paymentDetails: PaymentModels.FetchPayment.ViewModel)
}

final class PaymentPresenter: PaymentPresentationLogic {
    
    weak var viewController: PaymentDisplayLogic?
    
    func presentMovie(paymentDetails: PaymentModels.FetchPayment.ViewModel) {
        self.viewController?.displayFetchedMovie(viewModel: paymentDetails)
    }
}
