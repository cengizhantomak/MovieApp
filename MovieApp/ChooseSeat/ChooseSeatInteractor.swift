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
    func fetchTickets()
    func filterUnavailableSeats(seatFilter: [ChooseSeatModels.FetchChooseSeat.ViewModel.DisplayedTicket]) -> [String]
    func updateViewComponents(displayedSeatData: ChooseSeatModels.FetchChooseSeat.SeatDataModel.SeatData)
    func getSeatValue(for indexPath: IndexPath, row: [String], seat: [Int]) -> String
}

protocol ChooseSeatDataStore: AnyObject {
    var seatDetails: ChooseSeatModels.FetchChooseSeat.ViewModel? { get set }
}

final class ChooseSeatInteractor: ChooseSeatBusinessLogic, ChooseSeatDataStore {
    
    var presenter: ChooseSeatPresentationLogic?
    var worker: ChooseSeatWorkingLogic = ChooseSeatWorker()
    
    var seatDetails: ChooseSeatModels.FetchChooseSeat.ViewModel?
    
    func fetchTickets() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
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
    
    func filterUnavailableSeats(seatFilter: [ChooseSeatModels.FetchChooseSeat.ViewModel.DisplayedTicket]) -> [String] {
        return seatFilter.filter {
            $0.title == seatDetails?.selectedMovieTitle &&
            $0.date == seatDetails?.selectedDate &&
            $0.time == seatDetails?.selectedTime &&
            $0.theatre == seatDetails?.selectedTheater
        }.flatMap { $0.seat?.components(separatedBy: ", ") ?? [] }
    }
    
    func updateViewComponents(displayedSeatData: ChooseSeatModels.FetchChooseSeat.SeatDataModel.SeatData) {
        var selectedSeats = displayedSeatData.selectedSeats
        selectedSeats.sort()
        
        let totalAmount = Double(displayedSeatData.selectedSeats.count) * 18.00
        presenter?.presentUpdatedViewComponents(selectedSeats: selectedSeats, totalAmount: totalAmount)
    }
    
    func getSeatValue(for indexPath: IndexPath, row: [String], seat: [Int]) -> String {
        var combined = [String]()
        row.forEach { letter in
            seat.forEach { number in
                combined.append("\(letter)\(number)")
            }
        }
        return combined[indexPath.row]
    }
}
