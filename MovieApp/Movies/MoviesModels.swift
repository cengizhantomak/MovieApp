//
//  MoviesModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

enum MoviesModels {
    
    enum FetchMovies {
        
        struct Request {
            
        }
        
        struct Response {
            var movies: [MoviesResponse.MovieNowPlaying.Movie]
        }
        
        struct Response2 {
            var details: MoviesResponse.MovieDetail.Movie
        }
        
        struct ViewModel {
            var displayedMovies: [DisplayedMovie]
            
            struct DisplayedMovie {
                let title: String
                let releaseDate: String
                let posterPath: String
                let vote: Float
                let id: Int
            }
        }
        
        struct ViewModel2 {
            var displayedDetails: DisplayedDetails
            
            struct DisplayedDetails {
                let runtime: Int
            }
        }
    }
}
