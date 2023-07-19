//
//  TicketsInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 18.07.2023.
//

import Foundation
import UIKit

protocol TicketsBusinessLogic: AnyObject {
    func fetchTickets(request: TicketsModels.FetchTickets.Request)
}

protocol TicketsDataStore: AnyObject {
    
}

final class TicketsInteractor: TicketsBusinessLogic, TicketsDataStore {
    
    var presenter: TicketsPresentationLogic?
    var worker: TicketsWorkingLogic = TicketsWorker()
    
    func fetchTickets(request: TicketsModels.FetchTickets.Request) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let tickets = try worker.fetchTickets(using: context)
            let response = TicketsModels.FetchTickets.Response(tickets: tickets)
            presenter?.presentTickets(response: response)
        } catch {
            print("Failed to fetch tickets: \(error)")
        }
    }
}
