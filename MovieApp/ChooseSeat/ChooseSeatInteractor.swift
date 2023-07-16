//
//  ChooseSeatInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 14.07.2023.
//

import Foundation

protocol ChooseSeatBusinessLogic: AnyObject {
    func getMovie()
    func selectedSeatPrice(seat: [String], price: Double)
}

protocol ChooseSeatDataStore: AnyObject {
    var seatDetails: ChooseSeatModels.FetchChooseSeat.ViewModel? { get set }
}

final class ChooseSeatInteractor: ChooseSeatBusinessLogic, ChooseSeatDataStore {
    
    var presenter: ChooseSeatPresentationLogic?
    var worker: ChooseSeatWorkingLogic = ChooseSeatWorker()
    
    var seatDetails: ChooseSeatModels.FetchChooseSeat.ViewModel?
    
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
