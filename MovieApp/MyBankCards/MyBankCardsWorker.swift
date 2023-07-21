//
//  MyBankCardsWorker.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 21.07.2023.
//

import Foundation
import CoreData

protocol MyBankCardsWorkingLogic: AnyObject {
    func fetchBankCards(using context: NSManagedObjectContext) throws -> [BankCard]
}

final class MyBankCardsWorker: MyBankCardsWorkingLogic {
    
    func fetchBankCards(using context: NSManagedObjectContext) throws -> [BankCard] {
        let fetchRequest: NSFetchRequest<BankCard> = BankCard.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return try context.fetch(fetchRequest)
    }
}
