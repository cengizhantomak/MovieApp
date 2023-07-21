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
            var displayedBankCard: [DisplayedBankCard]
            
            struct DisplayedBankCard {
                let cardNumber: String
                let cardHolder: String
                let cardExpires: String
            }
        }
    }
}
