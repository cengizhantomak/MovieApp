//
//  SignUpModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 30.07.2023.
//

import Foundation

enum SignUpModels {
    struct SignUp {
        var url: String
    }
    
    enum FetchSignUp {
        struct Request {
        }
        
        struct Response {
            var signUp: SignUp
        }
        
        struct ViewModel {
            var url: String
        }
    }
}
