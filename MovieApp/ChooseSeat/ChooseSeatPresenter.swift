//
//  ChooseSeatPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 14.07.2023.
//

import Foundation

protocol ChooseSeatPresentationLogic: AnyObject {
    func presentMovie(seatDetails: ChooseSeatModels.FetchChooseSeat.ViewModel)
    func presentSeatPrice()
    func presentTickets(response: ChooseSeatModels.FetchChooseSeat.Response)
    func presentUpdatedViewComponents(selectedSeats: [String], totalAmount: Double)
}

final class ChooseSeatPresenter: ChooseSeatPresentationLogic {
    
    weak var viewController: ChooseSeatDisplayLogic?
    
    func presentTickets(response: ChooseSeatModels.FetchChooseSeat.Response) {
        let displayedTickets = response.tickets.compactMap { ticket in
            ChooseSeatModels.FetchChooseSeat.ViewModel.DisplayedTicket(
                title: ticket.title,
                imagePath: ticket.imagePath,
                date: ticket.date,
                time: ticket.time,
                theatre: ticket.theatre,
                seat: ticket.seat,
                totalAmount: ticket.totalAmount,
                id: ticket.id
            )
        }
        
        let viewModel = ChooseSeatModels.FetchChooseSeat.ViewModel(displayedTickets: displayedTickets)
        viewController?.displayTickets(viewModel: viewModel)
    }
    
    func presentMovie(seatDetails: ChooseSeatModels.FetchChooseSeat.ViewModel) {
        self.viewController?.displayFetchedMovie(viewModel: seatDetails)
    }
    
    func presentSeatPrice() {
        viewController?.displaySeatPrice()
    }
    
    func presentUpdatedViewComponents(selectedSeats: [String], totalAmount: Double) {
        viewController?.displayUpdatedViewComponents(selectedSeats: selectedSeats, totalAmount: totalAmount)
    }
}
