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
    func deleteTicket(withId id: UUID, using context: NSManagedObjectContext) throws
}

final class TicketsWorker: TicketsWorkingLogic {
    func fetchTickets(using context: NSManagedObjectContext) throws -> [MovieTicket] {
        let fetchRequest: NSFetchRequest<MovieTicket> = MovieTicket.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return try context.fetch(fetchRequest)
    }
    
    func deleteTicket(withId id: UUID, using context: NSManagedObjectContext) throws {
        let fetchRequest: NSFetchRequest<MovieTicket> = MovieTicket.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        let tickets = try context.fetch(fetchRequest)
        if let ticket = tickets.first {
            context.delete(ticket)
            try context.save()
        }
    }
}
