//
//  PaymentModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 15.07.2023.
//

import Foundation

enum PaymentModels {
    
    enum FetchPayment {
        
        struct Request {
            var nameCard: String?
            var cardNumber: String?
            var dateExpire: String?
            var cvv: String?
        }
        
        struct Response {
            var isValid: Bool
        }
        
        struct ViewModel {
            var selectedMovieTitle: String?
            var selectedMovieImage: String?
            var selectedDate: String?
            var selectedTheater: String?
            var chooseSeat: [String]?
            var totalAmount: Double?
            var message: String?
            var title: String?
            var buttonTitle: String?
            var isPaymentSuccessful: Bool?
            var cardNumber: String?
            var cardHolder: String?
            var cardExpires: String?
            var cvv: String?
            var id: UUID?
        }
    }
}
