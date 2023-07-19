//
//  TicketsWorker.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 18.07.2023.
//

import Foundation
import CoreData

protocol TicketsWorkingLogic: AnyObject {
    func fetchTickets(using context: NSManagedObjectContext) throws -> [MovieTicket]
}

final class TicketsWorker: TicketsWorkingLogic {
    func fetchTickets(using context: NSManagedObjectContext) throws -> [MovieTicket] {
        let fetchRequest: NSFetchRequest<MovieTicket> = MovieTicket.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return try context.fetch(fetchRequest)
    }
}
