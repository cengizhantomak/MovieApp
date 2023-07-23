//
//  ChooseSeatWorker.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 14.07.2023.
//

import Foundation
import CoreData

protocol ChooseSeatWorkingLogic: AnyObject {
    func fetchTickets(using context: NSManagedObjectContext) throws -> [MovieTicket]
}

final class ChooseSeatWorker: ChooseSeatWorkingLogic {
    func fetchTickets(using context: NSManagedObjectContext) throws -> [MovieTicket] {
        let fetchRequest: NSFetchRequest<MovieTicket> = MovieTicket.fetchRequest()
        
        return try context.fetch(fetchRequest)
    }
}
