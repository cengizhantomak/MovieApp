//
//  MovieDetailsModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

enum MovieDetailsModels {
    
    enum FetchMovieDetails {
        
        struct Request {
            
        }
        
        struct Response {
            var cast: [MoviesResponse.Cast]
            var details: MoviesResponse.Movie
            var images: [MoviesResponse.Images]
            var watchList: [MoviesResponse.Movie]
        }
        
        struct ViewModel {
            var displayedCast: [DisplayedCast]
            var displayedImages: [DisplayedImages]
            var displayedWatchList: [DisplayedWatchList]
            let title: String
            let overview: String
            let genres: String
            let runtime: Int
            let vote: Float
            let posterPhotoPath: String
            let id: Int
            
            struct DisplayedCast {
                let name: String
                let character: String
                let profilePhotoPath: String
            }
            
            struct DisplayedImages {
                let images: String
            }
            
            struct DisplayedWatchList {
                let watchListId: Int
            }
        }
    }
}
