//
//  PhotosModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 5.07.2023.
//

import Foundation

enum PhotosModels {
    enum FethcPhotos {
        struct Request {
        }
        
        struct Response {
            var photos: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedImages]
        }
        
        struct ViewModel {
            var displayedImages: [DisplayedImages]
            
            struct DisplayedImages {
                let images: String
            }
        }
    }
}
