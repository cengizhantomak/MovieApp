//
//  CongratsModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 17.07.2023.
//

import Foundation

enum CongratsModels {
    
    enum FetchCongrats {
        
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            let title: String?
            let imagePath: String?
            let date: String?
            let time: String?
            let theatre: String?
            let seat: String?
            let totalAmount: Double?
        }
    }
}
