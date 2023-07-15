//
//  GetTicketInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import Foundation

protocol GetTicketBusinessLogic: AnyObject {
    func getMovie()
    func selectedDateTheater(_ date: String, _ theater: String)
}

protocol GetTicketDataStore: AnyObject {
    var selectedMovieTitle: String? { get set }
    var selectedMovieImage: String? { get set }
    var selectedDate: String? { get set }
    var selectedTheater: String? { get set }
}

final class GetTicketInteractor: GetTicketBusinessLogic, GetTicketDataStore {
    
    var presenter: GetTicketPresentationLogic?
    var worker: GetTicketWorkingLogic = GetTicketWorker()
    
    var selectedMovieTitle: String?
    var selectedMovieImage: String?
    var selectedDate: String?
    var selectedTheater: String?
    
    func getMovie() {
        guard let selectedMovieTitle else { return }
        presenter?.presentMovie(selectedMovieTitle)
    }
    
    func selectedDateTheater(_ date: String, _ theater: String) {
        selectedDate = date
        selectedTheater = theater
        presenter?.presentDateTheater()
    }
}
