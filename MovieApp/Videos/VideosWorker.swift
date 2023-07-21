//
//  VideosWorker.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 21.07.2023.
//

import Foundation

protocol VideosWorkingLogic: AnyObject {
    func getMovieVideos(id: Int, _ completion: @escaping (Result<MoviesResponse.MovieVideos, RequestError>) -> Void)
}

final class VideosWorker: VideosWorkingLogic, HTTPClient {
    func getMovieVideos(id: Int, _ completion: @escaping (Result<MoviesResponse.MovieVideos, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.videos(id: id), responseModel: MoviesResponse.MovieVideos.self, completion: completion)
    }
}
