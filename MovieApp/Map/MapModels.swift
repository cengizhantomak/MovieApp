//
//  MapModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 20.07.2023.
//

import Foundation

enum MapModels {
    
    struct Theatre {
        let name: String
        let latitude: Double
        let longitude: Double
    }
    
    enum TheatreData {
        static let theatres = [
            Theatre(name: "Kadikoy", latitude: 40.991571, longitude: 29.027017),
            Theatre(name: "Besiktas", latitude: 41.042847, longitude: 29.009315),
            Theatre(name: "Taksim", latitude: 41.036945, longitude: 28.985150),
            Theatre(name: "Sisli", latitude: 41.060184, longitude: 28.987053),
            Theatre(name: "Avcilar", latitude: 40.980135, longitude: 28.717547),
        ]
    }
    
    enum FetchMap {
        
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
}
