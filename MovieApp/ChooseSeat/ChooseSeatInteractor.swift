//
//  ChooseSeatInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 14.07.2023.
//

import Foundation

protocol ChooseSeatBusinessLogic: AnyObject {
    func getMovie()
    func selectedSeatPrice(_ seat: [String], _ price: Double)
}

protocol ChooseSeatDataStore: AnyObject {
    var selectedMovieTitle: String? { get set }
    var selectedMovieImage: String? { get set }
    var selectedDate: String? { get set }
    var selectedTheater: String? { get set }
    var chooseSeat: [String] { get set }
    var totalAmount: Double? { get set }
}

final class ChooseSeatInteractor: ChooseSeatBusinessLogic, ChooseSeatDataStore {
    
    var presenter: ChooseSeatPresentationLogic?
    var worker: ChooseSeatWorkingLogic = ChooseSeatWorker()
    
    var selectedMovieTitle: String?
    var selectedMovieImage: String?
    var selectedDate: String?
    var selectedTheater: String?
    var chooseSeat: [String] = []
    var totalAmount: Double?
    
    func getMovie() {
        guard let selectedMovieTitle,
        let selectedMovieImage,
        let selectedDate,
        let selectedTheater else { return }
        presenter?.presentMovie(selectedMovieTitle, selectedMovieImage, selectedDate, selectedTheater)
    }
    
    func selectedSeatPrice(_ seat: [String], _ price: Double) {
        chooseSeat = seat
        totalAmount = price
        presenter?.presentSeatPrice()
    }
}
