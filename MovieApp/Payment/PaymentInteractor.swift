//
//  PaymentInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 15.07.2023.
//

import Foundation
import UIKit

protocol PaymentBusinessLogic: AnyObject {
    func getMovie()
    func validateCard(request: PaymentModels.FetchPayment.Request)
//    func updatePaymentDetails(with details: PaymentModels.FetchPayment.ViewModel)
    func getbankCardDetails()
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
    
    func validateCard(request: PaymentModels.FetchPayment.Request) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        if worker.checkTicketExists(paymentDetails: paymentDetails) {
            presenter?.presentTicketExistAlert()
            return
        }
        
        let fetchRequest = worker.createFetchRequest(request: request)
        
        do {
            let bankCards = try context.fetch(fetchRequest)
            let isValid = !bankCards.isEmpty
            let response = PaymentModels.FetchPayment.Response(isValid: isValid)
            presenter?.presentCardValidationResult(response: response)
            
            if response.isValid {
                saveMovieTicket()
            }
        } catch {
            print("Could not fetch card details. \(error)")
        }
    }
    
    func saveMovieTicket() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        guard (worker.createMovieTicket(paymentDetails: paymentDetails)) != nil else {
            print("Failed to create ticket in Interactor.")
            return
        }
        
        do {
            try context.save()
            print("Ticket saved successfully in Interactor.")
        } catch {
            print("Failed to save ticket in Interactor: \(error)")
        }
    }
    
//    func updatePaymentDetails(with details: PaymentModels.FetchPayment.ViewModel) {
//        self.paymentDetails = details
//    }
    
    func getbankCardDetails() {
        guard let paymentDetails else { return }
        presenter?.presentBankCardDetails(bankCardDetails: paymentDetails)
    }
}
