//
//  MoviesWorker.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

protocol MoviesWorkingLogic: AnyObject {
    func getNowPlaying(_ completion: @escaping (Result<MoviesResponse.NowPlaying, RequestError>) -> Void)
}

final class MoviesWorker: MoviesWorkingLogic, HTTPClient {
    func getNowPlaying(_ completion: @escaping (Result<MoviesResponse.NowPlaying, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.nowPlaying, responseModel: MoviesResponse.NowPlaying.self, completion: completion)
    }
}
