//
//  MoviesEndpoint.swift
//  Movie
//
//  Created by Cengizhan Tomak on 22.06.2023.
//

import Foundation

public enum MoviesEndpoint {
    case nowPlaying
    case popular
    case topRated
    case upcoming
    case moviesDetail(id: Int)
    case credits(id: Int)
    case images(id: Int)
    case videos(id: Int)
    case watchList
    case addToWatchlist(movieId: Int)
    case profile
    case removeFromWatchlist(movieId: Int)
    case createRequestToken
    case validateWithLogin
    case createSession
}

extension MoviesEndpoint: Endpoint {
    public var queryItems: [URLQueryItem]? {
        switch self {
        case .nowPlaying, .popular, .topRated, .upcoming, .moviesDetail(_), .credits(_), .images(_), .videos(_), .createRequestToken:
            return [URLQueryItem(name: "api_key", value: APIConstants.apiKey)]
        case  .watchList,.addToWatchlist(_), .profile, .removeFromWatchlist(_):
            return [
                URLQueryItem(name: "api_key", value: APIConstants.apiKey),
                URLQueryItem(name: "session_id", value: APIConstants.sessionId)
            ]
        case  .validateWithLogin, .createSession:
            return [
                URLQueryItem(name: "api_key", value: APIConstants.apiKey),
                URLQueryItem(name: "request_token", value: APIConstants.requestToken),
                URLQueryItem(name: "username", value: APIConstants.username),
                URLQueryItem(name: "password", value: APIConstants.password)
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
        case .videos(let id):
            return "/3/movie/\(id)/videos"
        case .watchList:
            return "/3/account/\(APIConstants.accountId)/watchlist/movies"
        case .addToWatchlist(_):
            return "/3/account/\(APIConstants.accountId)/watchlist"
        case .removeFromWatchlist(_):
            return "/3/account/\(APIConstants.accountId)/watchlist"
        case .profile:
            return "/3/account/\(APIConstants.accountId)"
        case .createRequestToken:
            return "/3/authentication/token/new"
        case .validateWithLogin:
            return "/3/authentication/token/validate_with_login"
        case .createSession:
            return "/3/authentication/session/new"
        }
    }
    
    public var method: RequestMethod {
        switch self {
        case .nowPlaying, .popular, .topRated, .upcoming, .moviesDetail, .credits, .images, .videos, .watchList, .profile, .createRequestToken:
            return .get
        case .addToWatchlist, .removeFromWatchlist, .validateWithLogin, .createSession:
            return .post
        }
    }
    
    public var header: [String : String]? {
        // TODO: Singleton Keychain Manager
        switch self {
        case .nowPlaying, .popular, .topRated, .upcoming, .moviesDetail, .credits, .images, .videos, .watchList, .addToWatchlist, .removeFromWatchlist, .profile, .createRequestToken, .validateWithLogin, .createSession:
            return [
                //                "Authorization": "Bearer \(accessToken)"
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    public var body: [String: Any]? {
        switch self {
        case .addToWatchlist(let movieId):
            return [
                "media_type": "movie",
                "media_id": "\(movieId)",
                "watchlist": true
            ]
        case .removeFromWatchlist(let movieId):
            return [
                "media_type": "movie",
                "media_id": "\(movieId)",
                "watchlist": false
            ]
        default:
            return nil
        }
    }
}
