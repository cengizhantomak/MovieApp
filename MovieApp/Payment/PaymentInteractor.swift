//
//  PaymentInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 15.07.2023.
//

import Foundation
import UIKit
import CoreData

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
    
    func getMovie() {
        guard let paymentDetails else { return }
        presenter?.presentMovie(paymentDetails: paymentDetails)
    }
    
    func validateCard(request: PaymentModels.FetchPayment.Request) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BankCard")
        fetchRequest.predicate = NSPredicate(format: "nameCard == %@ AND cardNumber == %@ AND dateExpire == %@ AND cvv == %@",
                                             request.nameCard ?? "",
                                             request.cardNumber ?? "",
                                             request.dateExpire ?? "",
                                             request.cvv ?? "")
        
        do {
            let bankCards = try context.fetch(fetchRequest)
            let response = PaymentModels.FetchPayment.Response(isValid: !bankCards.isEmpty)
            presenter?.presentCardValidationResult(response: response)
            
            // Kartın geçerli olup olmadığını kontrol edin ve öyleyse saveMovieTicket'i arayın.
            if response.isValid {
                saveMovieTicket()
            }
        } catch {
            print("Could not fetch card details. \(error)")
        }
    }
    
    func saveMovieTicket() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let newTicket = MovieTicket(context: context)
        newTicket.title = paymentDetails?.selectedMovieTitle
        newTicket.imagePath = paymentDetails?.selectedMovieImage
        newTicket.date = paymentDetails?.selectedDate
        newTicket.theatre = paymentDetails?.selectedTheater
        newTicket.seat = paymentDetails?.chooseSeat?.joined(separator: ",")
        newTicket.totalAmount = paymentDetails?.totalAmount ?? 0
        
        do {
            try context.save()
            print("Ticket saved successfully.")
        } catch {
            print("Failed to save ticket: \(error)")
        }
    }
}
