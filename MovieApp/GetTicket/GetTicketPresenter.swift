//
//  GetTicketPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import Foundation

protocol GetTicketPresentationLogic: AnyObject {
    func presentMovie(ticketDetails: GetTicketModels.FetchGetTicket.ViewModel)
    func presentDateTheater()
}

final class GetTicketPresenter: GetTicketPresentationLogic {
    
    weak var viewController: GetTicketDisplayLogic?
    
    func presentMovie(ticketDetails: GetTicketModels.FetchGetTicket.ViewModel) {
        self.viewController?.displayFetchedMovie(viewModel: ticketDetails)
    }
    
    func presentDateTheater() {
        viewController?.displayDateTheater()
    }
}
