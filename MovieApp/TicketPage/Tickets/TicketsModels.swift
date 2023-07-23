//
//  TicketsModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 18.07.2023.
//

import Foundation

enum TicketsModels {
    
    enum FetchTickets {
        
        struct Request {
            
        }
        
        struct Response {
            let tickets: [MovieTicket]
        }
        
        struct ViewModel {
            var displayedTickets: [DisplayedTicket]
            
            struct DisplayedTicket {
                let title: String
                let imagePath: String
                let date: String
                let time: String
                let theatre: String
                let seat: String
                let totalAmount: Double
                let id: UUID
            }
        }
    }
    
    enum DeleteTicket {
        
        struct Request {
            let ticketId: UUID
        }
        
        struct Response {
            let success: Bool
        }
        
        struct ViewModel {
            let success: Bool
        }
    }
}
