//
//  CongratsInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 17.07.2023.
//

import Foundation

protocol CongratsBusinessLogic: AnyObject {
    func fetchLatestTicket()
}

protocol CongratsDataStore: AnyObject {
    var movieTicket: MovieTicket? { get set }
}

final class CongratsInteractor: CongratsBusinessLogic, CongratsDataStore {
    
    var presenter: CongratsPresentationLogic?
    var worker: CongratsWorkingLogic = CongratsWorker()
    var movieTicket: MovieTicket?
    
    func fetchLatestTicket() {
        let ticket = worker.fetchLatestTicket()
        presenter?.presentLatestTicket(ticket: ticket)
    }
}
