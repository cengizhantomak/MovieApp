//
//  ChooseSeatModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 14.07.2023.
//

import Foundation

enum ChooseSeatModels {
    enum FetchChooseSeat {
        struct Request {
        }
        
        struct Response {
            let tickets: [MovieTicket]
        }
        
        struct ViewModel {
            var selectedMovieTitle: String?
            var selectedMovieImage: String?
            var selectedDate: String?
            var selectedTime: String?
            var selectedTheater: String?
            var chooseSeat: [String]?
            var totalAmount: Double?
            
            var displayedTickets: [DisplayedTicket]?
            
            struct DisplayedTicket {
                let title: String?
                let imagePath: String?
                let date: String?
                let time: String?
                let theatre: String?
                let seat: String?
                let totalAmount: Double?
                let id: UUID?
            }
        }
        
        struct SeatDataModel {
            var seatData: SeatData?
            
            struct SeatData {
                var unavailableSeats: [String] = []
                let row = ["A", "B", "C", "D", "E", "F", "G", "H", "I"]
                let seat = [1, 2, 3, 4, 5, 6, 7, 8, 9]
                var selectedSeats: [String] = []
                var totalAmount: Double = 0.0
            }
        }
    }
}
