//
//  VideosModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 21.07.2023.
//

import Foundation

enum VideosModels {
    enum FetchVideos {
        struct Request {
        }
        
        struct Response {
            var videos: [MoviesResponse.Videos]
        }
        
        struct ViewModel {
            var displayedVideos: [DisplayedVideos]
            
            struct DisplayedVideos {
                let name: String
                let key: String
            }
        }
    }
}
