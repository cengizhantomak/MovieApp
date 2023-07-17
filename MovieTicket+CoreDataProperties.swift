//
//  MovieTicket+CoreDataProperties.swift
//  MovieApp
//
//  Created by Kerem Tuna Tomak on 17.07.2023.
//
//

import Foundation
import CoreData


extension MovieTicket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieTicket> {
        return NSFetchRequest<MovieTicket>(entityName: "MovieTicket")
    }

    @NSManaged public var title: String?
    @NSManaged public var imagePath: String?
    @NSManaged public var date: String?
    @NSManaged public var theatre: String?
    @NSManaged public var seat: String?
    @NSManaged public var totalAmount: Double

}

extension MovieTicket : Identifiable {

}
