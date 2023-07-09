//
//  MoviesResponse.swift
//  Movie
//
//  Created by Cengizhan Tomak on 22.06.2023.
//

import Foundation

public struct MoviesResponse {
    public struct NowPlaying: Codable {
        public let results: [Movie]
    }
    
    public struct Movie: Codable {
        let title: String
        let releaseDate: String
        let posterPath: String
        let overview: String
        let id: Int
        let vote: Float
        let runtime: Int?
        public let genres: [Genres]?
        
        enum CodingKeys: String, CodingKey {
            case title, overview, id, runtime, genres
            case releaseDate = "release_date"
            case posterPath = "poster_path"
            case vote = "vote_average"
        }
    }
    
    public struct Genres: Codable {
        public let name: String
    }
    
    
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
    
    public struct Backdrops: Codable {
        let backdrops: [Images]
    }
    
    public struct Images: Codable {
        let images: String
        
        enum CodingKeys: String, CodingKey {
            case images = "file_path"
        }
    }
    
    struct Watchlist: Decodable {
        let statusCode: Int
        let statusMessage: String

        enum CodingKeys: String, CodingKey {
            case statusCode = "status_code"
            case statusMessage = "status_message"
        }
    }

    struct Profile: Codable {
        let avatar: Avatar
        let id: Int
        let name: String
        let username: String
    }

    struct Avatar: Codable {
        let tmdb: Tmdb
    }

    struct Tmdb: Codable {
        let avatarPath: String

        enum CodingKeys: String, CodingKey {
            case avatarPath = "avatar_path"
        }
    }
}
