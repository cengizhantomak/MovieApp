//
//  CastCrewModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 30.06.2023.
//

import Foundation

enum CastCrewModels {
    
    enum FetchCastCrew {
        
        struct Request {
            
        }
        
        struct Response {
            var cast: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedCast]
        }
        
        struct ViewModel {
            var displayedCast: [DisplayedCast]
            
            struct DisplayedCast {
                let name: String
                let character: String
                let profilePhotoPath: String
            }
        }
    }
}
