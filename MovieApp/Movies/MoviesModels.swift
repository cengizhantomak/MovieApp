//
//  MoviesModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

// swiftlint:disable nesting
enum MoviesModels {
    
    enum FetchMovies {
        
        struct Request {
            
        }
        
        struct Response {
            var movies: [MoviesResponse.MovieNowPlaying.Movie]
        }
        
        struct ViewModel {
            var displayedMovies: [DisplayedMovie]
            
            struct DisplayedMovie {
                let title: String
                let id: Int
            }
        }
        
    }
    
}
// swiftlint:enable nesting
