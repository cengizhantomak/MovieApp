//
//  GetTicketInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import Foundation
import UIKit

protocol GetTicketBusinessLogic: AnyObject {
    func getMovie()
    func selectedDateTheater(date: String, time: String, theater: String)
    func getDateRange(days: Int) -> (minDate: Date, maxDate: Date)
    func textFieldDidChangeSelection(textFields: [UITextField], button: UIButton)
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
    
    func textFieldDidChangeSelection(textFields: [UITextField], button: UIButton) {
        guard let dateTextField = textFields[0].text, !dateTextField.isEmpty,
              let timeTextField = textFields[1].text, !timeTextField.isEmpty,
              let theatreTextField = textFields[2].text, !theatreTextField.isEmpty else {
            button.isEnabled = false
            button.backgroundColor = .systemGray
            return
        }
        
        button.isEnabled = true
        button.backgroundColor = UIColor(named: "buttonRed")
    }
}
