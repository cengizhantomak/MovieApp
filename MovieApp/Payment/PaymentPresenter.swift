//
//  PaymentPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 15.07.2023.
//

import Foundation

protocol PaymentPresentationLogic: AnyObject {
    func presentMovie(paymentDetails: PaymentModels.FetchPayment.ViewModel)
    func presentBankCardDetails(bankCardDetails: PaymentModels.FetchPayment.ViewModel)
    func presentCardValidationResult(response: PaymentModels.FetchPayment.Response)
    func presentTicketExistAlert()
}

final class PaymentPresenter: PaymentPresentationLogic {
    
    weak var viewController: PaymentDisplayLogic?
    
    func presentMovie(paymentDetails: PaymentModels.FetchPayment.ViewModel) {
        self.viewController?.displayFetchedMovie(viewModel: paymentDetails)
    }
    
    func presentBankCardDetails(bankCardDetails: PaymentModels.FetchPayment.ViewModel) {
        self.viewController?.displayFetchedBankCardDetails(viewModel: bankCardDetails)
    }
    
    func presentTicketExistAlert() {
        let viewModel = PaymentModels.FetchPayment.ViewModel(
            message: "A ticket has already been purchased for this information.",
            title: "Error",
            buttonTitle: "Cancel")
        viewController?.displayCardValidationResult(viewModel: viewModel)
    }
    
    func presentCardValidationResult(response: PaymentModels.FetchPayment.Response) {
        let viewModel: PaymentModels.FetchPayment.ViewModel
        if response.isValid {
            viewModel = PaymentModels.FetchPayment.ViewModel(isPaymentSuccessful: true)
        } else {
            viewModel = PaymentModels.FetchPayment.ViewModel(
                message: "Bank card information not found. Please check your details.",
                title: "Error",
                buttonTitle: "OK")
        }
        viewController?.displayCardValidationResult(viewModel: viewModel)
    }
}
