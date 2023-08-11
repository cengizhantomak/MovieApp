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
            var movies: [MoviesResponse.Movie]
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
    }
}
