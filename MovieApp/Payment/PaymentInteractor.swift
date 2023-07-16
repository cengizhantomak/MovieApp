//
//  PaymentInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 15.07.2023.
//

import Foundation

protocol PaymentBusinessLogic: AnyObject {
    func getMovie()
}

protocol PaymentDataStore: AnyObject {
    var paymentDetails: PaymentModels.FetchPayment.ViewModel? { get set }
}

final class PaymentInteractor: PaymentBusinessLogic, PaymentDataStore {
    
    var presenter: PaymentPresentationLogic?
    var worker: PaymentWorkingLogic = PaymentWorker()
    
    var paymentDetails: PaymentModels.FetchPayment.ViewModel?
    
    func getMovie() {
        guard let paymentDetails else { return }
        presenter?.presentMovie(paymentDetails: paymentDetails)
    }
}
