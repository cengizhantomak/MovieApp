//
//  PaymentPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 15.07.2023.
//

import Foundation

protocol PaymentPresentationLogic: AnyObject {
    func presentMovie(paymentDetails: PaymentModels.FetchPayment.ViewModel)
    func presentCardValidationResult(response: PaymentModels.FetchPayment.Response)
}

final class PaymentPresenter: PaymentPresentationLogic {
    
    weak var viewController: PaymentDisplayLogic?
    
    func presentMovie(paymentDetails: PaymentModels.FetchPayment.ViewModel) {
        self.viewController?.displayFetchedMovie(viewModel: paymentDetails)
    }
    
    func presentCardValidationResult(response: PaymentModels.FetchPayment.Response) {
        let viewModel: PaymentModels.FetchPayment.ViewModel
        if response.isValid {
            viewModel = PaymentModels.FetchPayment.ViewModel(isPaymentSuccessful: true)
        } else {
            viewModel = PaymentModels.FetchPayment.ViewModel(message: "Bank card information not found. Please check your details.", title: "Error", buttonTitle: "OK")
        }
        viewController?.displayCardValidationResult(viewModel: viewModel)
    }
}
