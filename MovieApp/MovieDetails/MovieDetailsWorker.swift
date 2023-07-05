//
//  MovieDetailsWorker.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

protocol MovieDetailsWorkingLogic: AnyObject {
    func getMovieCredits(id: Int, _ completion: @escaping (Result<MoviesResponse.MovieCredits.Credits, RequestError>) -> Void)
    func getMovieDetails(id: Int, _ completion: @escaping (Result<MoviesResponse.MovieDetail.Movie, RequestError>) -> Void)
    func getMovieImages(id: Int, _ completion: @escaping (Result<MoviesResponse.MovieImages.Backdrops, RequestError>) -> Void)
}

final class MovieDetailsWorker: MovieDetailsWorkingLogic, HTTPClient {
    func getMovieCredits(id: Int, _ completion: @escaping (Result<MoviesResponse.MovieCredits.Credits, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.credits(id: id), responseModel: MoviesResponse.MovieCredits.Credits.self, completion: completion)
    }
    
    func getMovieDetails(id: Int, _ completion: @escaping (Result<MoviesResponse.MovieDetail.Movie, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.moviesDetail(id: id), responseModel: MoviesResponse.MovieDetail.Movie.self, completion: completion)
    }
    
    func getMovieImages(id: Int, _ completion: @escaping (Result<MoviesResponse.MovieImages.Backdrops, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.images(id: id), responseModel: MoviesResponse.MovieImages.Backdrops.self, completion: completion)
    }
    
}
