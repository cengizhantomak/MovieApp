//
//  MovieDetailsWorker.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

protocol MovieDetailsWorkingLogic: AnyObject {
    func getMovieCredits(id: Int, _ completion: @escaping (Result<MoviesResponse.Credits, RequestError>) -> Void)
    func getMovieDetails(id: Int, _ completion: @escaping (Result<MoviesResponse.Movie, RequestError>) -> Void)
    func getMovieImages(id: Int, _ completion: @escaping (Result<MoviesResponse.Backdrops, RequestError>) -> Void)
    func postToAddWatchlist(movieId: Int, _ completion: @escaping (Result<MoviesResponse.Watchlist, RequestError>) -> Void)
    func getWatchList(_ completion: @escaping (Result<MoviesResponse.NowPlaying, RequestError>) -> Void)
    func postToRemoveWatchlist(movieId: Int, _ completion: @escaping (Result<MoviesResponse.Watchlist, RequestError>) -> Void)
}

final class MovieDetailsWorker: MovieDetailsWorkingLogic, HTTPClient {
    let httpClient: HTTPClient
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func getMovieCredits(id: Int, _ completion: @escaping (Result<MoviesResponse.Credits, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.credits(id: id), responseModel: MoviesResponse.Credits.self, completion: completion)
    }
    
    func getMovieDetails(id: Int, _ completion: @escaping (Result<MoviesResponse.Movie, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.moviesDetail(id: id), responseModel: MoviesResponse.Movie.self, completion: completion)
    }
    
    func getMovieImages(id: Int, _ completion: @escaping (Result<MoviesResponse.Backdrops, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.images(id: id), responseModel: MoviesResponse.Backdrops.self, completion: completion)
    }
    
    func postToAddWatchlist(movieId: Int, _ completion: @escaping (Result<MoviesResponse.Watchlist, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.addToWatchlist(movieId: movieId), responseModel: MoviesResponse.Watchlist.self, completion: completion)
    }
    
    func getWatchList(_ completion: @escaping (Result<MoviesResponse.NowPlaying, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.watchList, responseModel: MoviesResponse.NowPlaying.self, completion: completion)
    }
    
    func postToRemoveWatchlist(movieId: Int, _ completion: @escaping (Result<MoviesResponse.Watchlist, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.removeFromWatchlist(movieId: movieId), responseModel: MoviesResponse.Watchlist.self, completion: completion)
    }
}
