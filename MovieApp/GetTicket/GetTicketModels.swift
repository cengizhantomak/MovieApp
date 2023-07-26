//
//  GetTicketModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import Foundation

enum GetTicketModels {
    
    enum FetchGetTicket {
        
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            var selectedMovieTitle: String?
            var selectedMovieImage: String?
            var selectedDate: String?
            var selectedTime: String?
            var selectedTheater: String?
        }
        
        struct GetTicketData {
            let theaters = ["Kadikoy", "Besiktas", "Taksim", "Sisli", "Avcilar"]
            let times = ["10:00 - 12:30", "13:00 - 15:30", "16:00 - 18:30", "19:00 - 21:30", "22:00 - 00:30"]
        }
    }
}
