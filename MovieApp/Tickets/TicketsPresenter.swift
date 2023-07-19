//
//  TicketsPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 18.07.2023.
//

import Foundation

protocol TicketsPresentationLogic: AnyObject {
    func presentTickets(response: TicketsModels.FetchTickets.Response)
}

final class TicketsPresenter: TicketsPresentationLogic {
    
    weak var viewController: TicketsDisplayLogic?
    
    func presentTickets(response: TicketsModels.FetchTickets.Response) {
        let displayedTickets = response.tickets.compactMap { ticket in
            TicketsModels.FetchTickets.ViewModel.DisplayedTicket(
                title: ticket.title ?? "",
                imagePath: ticket.imagePath ?? "",
                date: ticket.date ?? "",
                theatre: ticket.theatre ?? "",
                seat: ticket.seat ?? "",
                totalAmount: ticket.totalAmount)
        }
        
        let viewModel = TicketsModels.FetchTickets.ViewModel(displayedTickets: displayedTickets)
        viewController?.displayTickets(viewModel: viewModel)
    }
}
