//
//  ChooseSeatInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 14.07.2023.
//

import Foundation
import UIKit

protocol ChooseSeatBusinessLogic: AnyObject {
    func getMovie()
    func selectedSeatPrice(seat: [String], price: Double)
    func fetchTickets(request: ChooseSeatModels.FetchChooseSeat.Request)
}

protocol ChooseSeatDataStore: AnyObject {
    var seatDetails: ChooseSeatModels.FetchChooseSeat.ViewModel? { get set }
}

final class ChooseSeatInteractor: ChooseSeatBusinessLogic, ChooseSeatDataStore {
    
    var presenter: ChooseSeatPresentationLogic?
    var worker: ChooseSeatWorkingLogic = ChooseSeatWorker()
    
    var seatDetails: ChooseSeatModels.FetchChooseSeat.ViewModel?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchTickets(request: ChooseSeatModels.FetchChooseSeat.Request) {
        do {
            let tickets = try worker.fetchTickets(using: context)
            let response = ChooseSeatModels.FetchChooseSeat.Response(tickets: tickets)
            presenter?.presentTickets(response: response)
        } catch {
            print("Failed to fetch tickets: \(error)")
        }
    }
    
    func getMovie() {
        guard let seatDetails else { return }
        presenter?.presentMovie(seatDetails: seatDetails)
    }
    
    func selectedSeatPrice(seat: [String], price: Double) {
        seatDetails?.chooseSeat = seat
        seatDetails?.totalAmount = price
        presenter?.presentSeatPrice()
    }
}
