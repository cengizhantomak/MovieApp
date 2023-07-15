//
//  GetTicketPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import Foundation

protocol GetTicketPresentationLogic: AnyObject {
    func presentMovie(_ displayedTitle: String)
    func presentDateTheater()
}

final class GetTicketPresenter: GetTicketPresentationLogic {
    
    weak var viewController: GetTicketDisplayLogic?
    
    func presentMovie(_ displayedTitle: String) {
        let displayedMovie = GetTicketModels.FetchGetTicket.ViewModel(selectedMovieTitle: displayedTitle)
        self.viewController?.displayFetchedMovie(viewModel: displayedMovie)
    }
    
    func presentDateTheater() {
        viewController?.displayDateTheater()
    }
}
