//
//  CongratsPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 17.07.2023.
//

import Foundation

protocol CongratsPresentationLogic: AnyObject {
    func presentLatestTicket(ticket: MovieTicket?)
}

final class CongratsPresenter: CongratsPresentationLogic {
    
    weak var viewController: CongratsDisplayLogic?
    
    func presentLatestTicket(ticket: MovieTicket?) {
        guard let ticket else { return }
        let viewModel = CongratsModels.FetchCongrats.ViewModel(
            title: ticket.title,
            imagePath: ticket.imagePath,
            date: ticket.date,
            time: ticket.time,
            theatre: ticket.theatre,
            seat: ticket.seat,
            totalAmount: ticket.totalAmount)
        
        viewController?.displayLatestTicket(viewModel: viewModel)
    }
}
