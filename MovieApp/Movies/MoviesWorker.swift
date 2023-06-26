//
//  MoviesWorker.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

protocol MoviesWorkingLogic: AnyObject {
    func getTopRatedMovies(_ completion: @escaping (Result<MoviesResponse.TopRated, RequestError>) -> Void)
}

final class MoviesWorker: MoviesWorkingLogic, HTTPClient {
    func getTopRatedMovies(_ completion: @escaping (Result<MoviesResponse.TopRated, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.topRated, responseModel: MoviesResponse.TopRated.self, completion: completion)
    }
}
