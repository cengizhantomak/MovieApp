//
//  CongratsWorker.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 17.07.2023.
//

import Foundation
import UIKit
import CoreData

protocol CongratsWorkingLogic: AnyObject {
    func fetchLatestTicket() -> MovieTicket?
}

final class CongratsWorker: CongratsWorkingLogic {
    func fetchLatestTicket() -> MovieTicket? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<MovieTicket> = MovieTicket.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        fetchRequest.fetchLimit = 1
        
        do {
            let tickets = try context.fetch(fetchRequest)
            return tickets.first
        } catch {
            print("Failed to fetch tickets: \(error)")
            return nil
        }
    }
}
