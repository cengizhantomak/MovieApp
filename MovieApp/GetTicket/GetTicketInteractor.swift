//
//  GetTicketInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import Foundation

protocol GetTicketBusinessLogic: AnyObject {
    func getMovie()
    func selectedDateTheater(date: String, time: String, theater: String)
    func getDateRange(days: Int) -> (minDate: Date, maxDate: Date)
}

protocol GetTicketDataStore: AnyObject {
    var ticketDetails: GetTicketModels.FetchGetTicket.ViewModel? { get set }
}

final class GetTicketInteractor: GetTicketBusinessLogic, GetTicketDataStore {
    
    var presenter: GetTicketPresentationLogic?
    var worker: GetTicketWorkingLogic = GetTicketWorker()
    
    var ticketDetails: GetTicketModels.FetchGetTicket.ViewModel?
    
    func getMovie() {
        guard let ticketDetails else { return }
        presenter?.presentMovie(ticketDetails: ticketDetails)
    }
    
    func selectedDateTheater(date: String, time: String, theater: String) {
        ticketDetails?.selectedDate = date
        ticketDetails?.selectedTime = time
        ticketDetails?.selectedTheater = theater
        presenter?.presentDateTheater()
    }
    
    func getDateRange(days: Int) -> (minDate: Date, maxDate: Date) {
        let currentDate = Date()
        let futureDate = Calendar.current.date(byAdding: .day, value: days, to: currentDate) ?? currentDate
        return (currentDate, futureDate)
    }
}
