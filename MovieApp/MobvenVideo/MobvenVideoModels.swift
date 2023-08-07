//
//  MobvenVideoModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.08.2023.
//

import Foundation

enum MobvenVideoModels {
    
    enum PlayVideo {
        
        struct Request {
            
        }
        
        struct Response {
            var isPlaying: Bool
        }
        
        struct ViewModel {
            var buttonTitle: String
        }
    }
}
