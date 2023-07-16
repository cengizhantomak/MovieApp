//
//  AddBankCardInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 16.07.2023.
//

import Foundation
import UIKit
import CoreData

protocol AddBankCardBusinessLogic: AnyObject {
    func saveBankCard(cardName: String, cardNumber: String, expiryDate: String, cvv: String, viewController: UIViewController)
}

protocol AddBankCardDataStore: AnyObject {
    
}

final class AddBankCardInteractor: AddBankCardBusinessLogic, AddBankCardDataStore {
    
    var presenter: AddBankCardPresentationLogic?
    var worker: AddBankCardWorkingLogic = AddBankCardWorker()
    
    func saveBankCard(cardName: String, cardNumber: String, expiryDate: String, cvv: String, viewController: UIViewController) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if checkCardExistence(cardNumber: cardNumber, context: context) {
            // Kart zaten var
            print("This card already exists in CoreData.")
            UIAlertHelper.shared.showAlert(
                title: "Error",
                message: "This card already exists.",
                buttonTitle: "OK",
                on: viewController)
        } else {
            // Kart mevcut değil, CoreData'ya kaydedin
            let bankCardEntity = NSEntityDescription.entity(forEntityName: "BankCard", in: context)!
            let newBankCard = NSManagedObject(entity: bankCardEntity, insertInto: context)
            
            newBankCard.setValue(cardName, forKey: "nameCard")
            newBankCard.setValue(cardNumber, forKey: "cardNumber")
            newBankCard.setValue(expiryDate, forKey: "dateExpire")
            newBankCard.setValue(cvv, forKey: "cvv")
            
            do {
                try context.save()
                print("Bank Card saved successfully!")
                UIAlertHelper.shared.showAlert(
                    title: "Success",
                    message: "Bank Card saved successfully!",
                    buttonTitle: "OK",
                    on: viewController
                )
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                UIAlertHelper.shared.showAlert(
                    title: "Error",
                    message: "Could not save. \(error), \(error.userInfo)",
                    buttonTitle: "OK",
                    on: viewController
                )
            }
        }
    }
    
    func checkCardExistence(cardNumber: String, context: NSManagedObjectContext) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BankCard")
        request.predicate = NSPredicate(format: "cardNumber = %@", cardNumber)
        request.fetchLimit = 1
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
}
