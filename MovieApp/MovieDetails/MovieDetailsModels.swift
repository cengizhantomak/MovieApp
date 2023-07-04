//
//  MovieDetailsModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

enum MovieDetailsModels {
    
    enum FetchNames {
        
        struct Request {
            
        }
        
        struct Response {
            var names: [MoviesResponse.MovieCredits.Cast]
        }
        
        struct Response2 {
            var details: MoviesResponse.MovieDetail.Movie
        }
        
        struct ViewModel {
            var displayedCast: [DisplayedCast]
            
            struct DisplayedCast {
                let name: String
                let character: String
                let profilePath: String
            }
        }
        
        struct ViewModel2 {
            var displayedDetails: DisplayedDetails
            
            struct DisplayedDetails {
                let title: String
                let overview: String
                let genres: String
                let runtime: Int
                let vote: Float
                let posterPath: String
            }
        }
        
    }
    
}