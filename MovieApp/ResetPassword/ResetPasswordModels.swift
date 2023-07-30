//
//  ResetPasswordModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 30.07.2023.
//

import Foundation

enum ResetPasswordModels {
    
    struct ResetPassword {
        var url: String
    }
    
    enum FetchResetPassword {
        
        struct Request {
            
        }
        
        struct Response {
            var resetPassword: ResetPassword
        }
        
        struct ViewModel {
            var url: String
        }
    }
}
