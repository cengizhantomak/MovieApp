//
//  MoviesResponse.swift
//  Movie
//
//  Created by Cengizhan Tomak on 22.06.2023.
//

import Foundation

public struct MoviesResponse {
    public struct MovieNowPlaying: Codable {
        public struct NowPlaying: Codable {
            let page: Int
            let totalPages: Int
            let totalResults: Int
            public let results: [Movie]
            
            enum CodingKeys: String, CodingKey {
                case page, results
                case totalPages = "total_pages"
                case totalResults = "total_results"
            }
        }
        
        public struct Movie: Codable {
            let title: String
            let releaseDate: String
            let posterPath: String
            let overview: String
            let vote: Float
            let id: Int
            
            enum CodingKeys: String, CodingKey {
                case title, overview, id
                case releaseDate = "release_date"
                case posterPath = "poster_path"
                case vote = "vote_average"
            }
        }
    }
    
    public struct MovieDetail: Codable {
        public struct Movie: Codable {
            let title: String
            let releaseDate: String
            let posterPath: String
            let overview: String
            let id: Int
            let runtime: Int
            let vote: Float
            public let genres: [Genres]
            
            enum CodingKeys: String, CodingKey {
                case title, overview, id, runtime, genres
                case releaseDate = "release_date"
                case posterPath = "poster_path"
                case vote = "vote_average"
            }
        }
        
        public struct Genres: Codable {
            public let genresName: String
            
            enum CodingKeys: String, CodingKey {
                case genresName = "name"
            }
        }
    }
    
    public struct MovieCredits: Codable {
        public struct Credits: Codable {
            public let cast: [Cast]
        }
        
        public struct Cast: Codable {
            let profilePhoto: String?
            let name: String?
            let character: String?
            
            enum CodingKeys: String, CodingKey {
                case name, character
                case profilePhoto = "profile_path"
            }
        }
    }
    
    public struct MovieImages: Codable {
        public struct Backdrops: Codable {
            let backdrops: [Images]
        }
        
        public struct Images: Codable {
            let images: String
            
            enum CodingKeys: String, CodingKey {
                case images = "file_path"
            }
        }
    }
    
}
