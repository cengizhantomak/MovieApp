//
//  WatchlistModels.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import Foundation

enum WatchlistModels {
    
    enum FetchWatchList {
        
        struct Request {
            
        }
        
        struct Response {
            var watchList: [MoviesResponse.MovieNowPlaying.Movie]
        }
        
        struct ViewModel {
            var displayedWatchList: [DisplayedWatchList]
            
            struct DisplayedWatchList {
                let title: String
                let releaseDate: String
                let posterPath: String
                let vote: Float
                let id: Int
            }
        }
    }
}
