//
//  PaymentInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 15.07.2023.
//

import Foundation

protocol PaymentBusinessLogic: AnyObject {
    func getMovie()
}

protocol PaymentDataStore: AnyObject {
    var selectedMovieTitle: String? { get set }
    var selectedMovieImage: String? { get set }
    var selectedDate: String? { get set }
    var selectedTheater: String? { get set }
    var chooseSeat: [String] { get set }
    var totalAmount: Double? { get set }
}

final class PaymentInteractor: PaymentBusinessLogic, PaymentDataStore {
    
    var presenter: PaymentPresentationLogic?
    var worker: PaymentWorkingLogic = PaymentWorker()
    
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
        let selectedTheater,
        let totalAmount else { return }
        print("wwwwwwwww: \(selectedMovieTitle),,,,\(selectedMovieImage),,,,,,\(selectedDate),,,,,\(selectedTheater)-------\(chooseSeat)-------\(totalAmount)")
        presenter?.presentMovie(selectedMovieTitle, selectedMovieImage, selectedDate, selectedTheater, chooseSeat, totalAmount)
    }
}
