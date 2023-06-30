//
//  MovieDetailsModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

// swiftlint:disable nesting
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
            }
        }
        
        struct ViewModel2 {
//            var displayedDetails: DisplayedDetails
//
//            struct DisplayedDetails {
                let title: String
                let overview: String
                let genres: String
            let runtime: Int
                let vote: Float
//            }
        }
        
    }
    
}
// swiftlint:enable nesting
