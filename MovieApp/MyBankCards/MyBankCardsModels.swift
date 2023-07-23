//
//  MyBankCardsModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 21.07.2023.
//

import Foundation

enum MyBankCardsModels {
    
    enum FetchMyBankCards {
        
        struct Request {
            
        }
        
        struct Response {
            let bankCards: [BankCard]
        }
        
        struct ViewModel {
            var displayedBankCard: [DisplayedBankCard]?
            var originViewController: String?
            var selectedMovieTitle: String?
            var selectedMovieImage: String?
            var selectedDate: String?
            var selectedTime: String?
            var selectedTheater: String?
            var chooseSeat: [String]?
            var totalAmount: Double?
            
            struct DisplayedBankCard {
                let cardNumber: String?
                let cardHolder: String?
                let cardExpires: String?
                let cvv: String?
                let id: UUID?
                
            }
        }
    }
    
    enum DeleteBankCard {
        
        struct Request {
            let bankCardId: UUID
        }
        
        struct Response {
            let success: Bool
        }
        
        struct ViewModel {
            let success: Bool
        }
    }
}
