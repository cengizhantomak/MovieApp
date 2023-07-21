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
    func deleteBankCard(withId id: UUID, using context: NSManagedObjectContext) throws
}

final class MyBankCardsWorker: MyBankCardsWorkingLogic {
    
    func fetchBankCards(using context: NSManagedObjectContext) throws -> [BankCard] {
        let fetchRequest: NSFetchRequest<BankCard> = BankCard.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return try context.fetch(fetchRequest)
    }
    
    func deleteBankCard(withId id: UUID, using context: NSManagedObjectContext) throws {
        let fetchRequest: NSFetchRequest<BankCard> = BankCard.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        let bankCards = try context.fetch(fetchRequest)
        if let bankCard = bankCards.first {
            context.delete(bankCard)
            try context.save()
        }
    }
}
