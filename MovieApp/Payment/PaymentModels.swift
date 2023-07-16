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
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            var selectedMovieTitle: String?
            var selectedMovieImage: String?
            var selectedDate: String?
            var selectedTheater: String?
            var chooseSeat: [String]?
            var totalAmount: Double?
        }
    }
}
