//
//  ProfileModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 8.07.2023.
//

import Foundation

enum ProfileModels {
    
    enum FetchProfile {
        
        struct Request {
            
        }
        
        struct Response {
            var profile: ProfileResponse
        }
        
        struct ViewModel {
            let id: Int
            let name: String
            let username: String
            let avatarPath: String
        }
    }
}
