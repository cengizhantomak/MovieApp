//
//  BankCard+CoreDataProperties.swift
//  MovieApp
//
//  Created by Kerem Tuna Tomak on 17.07.2023.
//
//

import Foundation
import CoreData


extension BankCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BankCard> {
        return NSFetchRequest<BankCard>(entityName: "BankCard")
    }

    @NSManaged public var cardNumber: String?
    @NSManaged public var cvv: String?
    @NSManaged public var dateExpire: String?
    @NSManaged public var nameCard: String?
    @NSManaged public var timestamp: Date?

}

extension BankCard : Identifiable {

}
