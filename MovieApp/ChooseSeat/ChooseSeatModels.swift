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
    }
}
