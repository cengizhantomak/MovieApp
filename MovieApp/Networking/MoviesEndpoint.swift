//
//  MoviesEndpoint.swift
//  Movie
//
//  Created by Cengizhan Tomak on 22.06.2023.
//

import Foundation

public enum MoviesEndpoint {
    case topRated
    case moviesDetail(id: Int)
}

extension MoviesEndpoint: Endpoint {
    public var queryItems: [URLQueryItem]? {
        switch self {
        case .topRated:
            return [URLQueryItem(name: "api_key", value: "ee3a8f4fad83f7af9b46376ca2d6104b")]
        case .moviesDetail(_):
            return nil
        }
    }
    
    public var path: String {
        switch self {
        case .topRated:
            return "/3/movie/now_playing"
        case .moviesDetail(let id):
            return "/3/movie/\(id)"
        }
    }
    
    public var method: RequestMethod {
        switch self {
        case .topRated, .moviesDetail:
            return .get
        }
    }
    
    public var header: [String : String]? {
        // TODO: Singleton Keychain Manager
        switch self {
        case .topRated, .moviesDetail:
            return [
                //                "Authorization": "Bearer \(accessToken)"
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    public var body: [String: String]? {
        return nil
    }
}
