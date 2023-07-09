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
            
        }
        
        struct ViewModel {
            var displayedCast: [DisplayedCast]
            var displayedImages: [DisplayedImages]
            let title: String
            let overview: String
            let genres: String
            let runtime: Int
            let vote: Float
            let posterPhotoPath: String
            
            struct DisplayedCast {
                let name: String
                let character: String
                let profilePhotoPath: String
            }
            
            struct DisplayedImages {
                let images: String
            }
        }
    }
}
