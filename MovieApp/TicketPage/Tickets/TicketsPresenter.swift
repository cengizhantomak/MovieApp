//
//  TicketsPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 18.07.2023.
//

import Foundation

protocol TicketsPresentationLogic: AnyObject {
    func presentTickets(response: TicketsModels.FetchTickets.Response)
    func presentDeleteTicketResult(response: TicketsModels.DeleteTicket.Response)
}

final class TicketsPresenter: TicketsPresentationLogic {
    
    weak var viewController: TicketsDisplayLogic?
    
    func presentTickets(response: TicketsModels.FetchTickets.Response) {
        let displayedTickets = response.tickets.compactMap { ticket in
            TicketsModels.FetchTickets.ViewModel.DisplayedTicket(
                title: ticket.title ?? "",
                imagePath: ticket.imagePath ?? "",
                date: ticket.date ?? "",
                time: ticket.time ?? "",
                theatre: ticket.theatre ?? "",
                seat: ticket.seat ?? "",
                totalAmount: ticket.totalAmount,
                id: ticket.id
            )
        }
        
        let viewModel = TicketsModels.FetchTickets.ViewModel(displayedTickets: displayedTickets)
        viewController?.displayTickets(viewModel: viewModel)
    }
    
    func presentDeleteTicketResult(response: TicketsModels.DeleteTicket.Response) {
        let viewModel = TicketsModels.DeleteTicket.ViewModel(success: response.success)
        viewController?.displayDeleteTicketResult(viewModel: viewModel)
    }
}
