//
//  WatchlistWorker.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import Foundation

protocol WatchlistWorkingLogic: AnyObject {
    func getWatchList(_ completion: @escaping (Result<MoviesResponse.NowPlaying, RequestError>) -> Void)
}

final class WatchlistWorker: WatchlistWorkingLogic, HTTPClient {
    func getWatchList(_ completion: @escaping (Result<MoviesResponse.NowPlaying, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.watchList, responseModel: MoviesResponse.NowPlaying.self, completion: completion)
    }
}
