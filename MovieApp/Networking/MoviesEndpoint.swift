//
//  MoviesEndpoint.swift
//  Movie
//
//  Created by Cengizhan Tomak on 22.06.2023.
//

import Foundation

struct APIConstants {
    static let apiKey = "ee3a8f4fad83f7af9b46376ca2d6104b"
    static let sessionId = "76c46b2e8222cbd0bc9c1dbd0c3667151253e0c0"
    static let accountId = "18128950"
}

public enum MoviesEndpoint {
    case nowPlaying
    case popular
    case topRated
    case upcoming
    case moviesDetail(id: Int)
    case credits(id: Int)
    case images(id: Int)
    case watchList
    case addToWatchlist(movieId: Int)
}

extension MoviesEndpoint: Endpoint {
    public var queryItems: [URLQueryItem]? {
        switch self {
        case .nowPlaying, .popular, .topRated, .upcoming, .moviesDetail(_), .credits(_), .images(_):
            return [URLQueryItem(name: "api_key", value: APIConstants.apiKey)]
        case  .watchList:
            return [
                URLQueryItem(name: "api_key", value: APIConstants.apiKey),
                URLQueryItem(name: "session_id", value: APIConstants.sessionId)]
        case .addToWatchlist(_):
            return [
                URLQueryItem(name: "api_key", value: APIConstants.apiKey),
                URLQueryItem(name: "session_id", value: APIConstants.sessionId)
            ]
        }
    }
    
    public var path: String {
        switch self {
        case .nowPlaying:
            return "/3/movie/now_playing"
        case .popular:
            return "/3/movie/popular"
        case .topRated:
            return "/3/movie/top_rated"
        case .upcoming:
            return "/3/movie/upcoming"
        case .moviesDetail(let id):
            return "/3/movie/\(id)"
        case .credits(let id):
            return "/3/movie/\(id)/credits"
        case .images(let id):
            return "/3/movie/\(id)/images"
        case .watchList:
            return "/3/account/\(APIConstants.accountId)/watchlist/movies"
        case .addToWatchlist(_):
            return "/3/account/\(APIConstants.accountId)/watchlist"
        }
    }
    
    public var method: RequestMethod {
        switch self {
        case .nowPlaying, .popular, .topRated, .upcoming, .moviesDetail, .credits, .images, .watchList:
            return .get
        case .addToWatchlist:
            return .post
        }
    }
    
    public var header: [String : String]? {
        // TODO: Singleton Keychain Manager
        switch self {
        case .nowPlaying, .popular, .topRated, .upcoming, .moviesDetail, .credits, .images, .watchList, .addToWatchlist:
            return [
                //                "Authorization": "Bearer \(accessToken)"
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    public var body: [String: String]? {
        switch self {
        case .nowPlaying, .popular, .topRated, .upcoming, .moviesDetail, .credits, .images, .watchList:
            return nil
        case .addToWatchlist(let movieId):
            return [
                "media_type": "movie",
                "media_id": "\(movieId)",
                "watchlist": "true"
            ]
        }
    }
}
