//
//  PaymentWorker.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 15.07.2023.
//

import Foundation
import UIKit
import CoreData

protocol PaymentWorkingLogic: AnyObject {
    func createFetchRequest(request: PaymentModels.FetchPayment.Request) -> NSFetchRequest<NSManagedObject>
    func createMovieTicket(paymentDetails: PaymentModels.FetchPayment.ViewModel?) -> MovieTicket?
    func checkTicketExists(paymentDetails: PaymentModels.FetchPayment.ViewModel?) -> Bool
}

final class PaymentWorker: PaymentWorkingLogic {
    func checkTicketExists(paymentDetails: PaymentModels.FetchPayment.ViewModel?) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let paymentDetails else { return false }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieTicket")
        fetchRequest.predicate = NSPredicate(
            format: "title == %@ AND date == %@ AND time == %@ AND theatre == %@ AND seat == %@",
            paymentDetails.selectedMovieTitle ?? "",
            paymentDetails.selectedDate ?? "",
            paymentDetails.selectedTime ?? "",
            paymentDetails.selectedTheater ?? "",
            paymentDetails.chooseSeat?.joined(separator: ", ") ?? "")
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            return !fetchedResults.isEmpty
        } catch let error {
            print("Error checking ticket existence: \(error)")
            return false
        }
    }
    
    func createFetchRequest(request: PaymentModels.FetchPayment.Request) -> NSFetchRequest<NSManagedObject> {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BankCard")
        fetchRequest.predicate = NSPredicate(
            format: "nameCard == %@ AND cardNumber == %@ AND dateExpire == %@ AND cvv == %@",
            request.nameCard ?? "",
            request.cardNumber ?? "",
            request.dateExpire ?? "",
            request.cvv ?? "")
        
        return fetchRequest
    }
    
    func createMovieTicket(paymentDetails: PaymentModels.FetchPayment.ViewModel?) -> MovieTicket? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        
        let newTicket = MovieTicket(context: context)
        newTicket.title = paymentDetails?.selectedMovieTitle
        newTicket.imagePath = paymentDetails?.selectedMovieImage
        newTicket.date = paymentDetails?.selectedDate
        newTicket.time = paymentDetails?.selectedTime
        newTicket.theatre = paymentDetails?.selectedTheater
        newTicket.seat = paymentDetails?.chooseSeat?.joined(separator: ", ")
        newTicket.totalAmount = paymentDetails?.totalAmount ?? 0
        newTicket.timestamp = Date()
        newTicket.id = UUID()
        
        return newTicket
    }
}
