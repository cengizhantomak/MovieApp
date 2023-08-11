//
//  LinkedInModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 29.07.2023.
//

import Foundation

enum LinkedInModels {
    struct Profile {
        var url: String
    }

    enum FetchLinkedIn {
        struct Request {
        }
        
        struct Response {
            var profile: Profile
        }
        
        struct ViewModel {
            var url: String
        }
    }
}
