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
}

protocol PaymentDataStore: AnyObject {
    var paymentDetails: PaymentModels.FetchPayment.ViewModel? { get set }
}

final class PaymentInteractor: PaymentBusinessLogic, PaymentDataStore {
    
    var presenter: PaymentPresentationLogic?
    var worker: PaymentWorkingLogic = PaymentWorker()
    
    var paymentDetails: PaymentModels.FetchPayment.ViewModel?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getMovie() {
        guard let paymentDetails else { return }
        presenter?.presentMovie(paymentDetails: paymentDetails)
    }
    
    func validateCard(request: PaymentModels.FetchPayment.Request) {
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
        guard let newTicket = worker.createMovieTicket(paymentDetails: paymentDetails) else {
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
}
