//
//  ProfileWorker.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 8.07.2023.
//

import Foundation

protocol ProfileWorkingLogic: AnyObject {
    func getProfile(_ completion: @escaping (Result<MoviesResponse.Profile, RequestError>) -> Void)}

final class ProfileWorker: ProfileWorkingLogic, HTTPClient {
    func getProfile(_ completion: @escaping (Result<MoviesResponse.Profile, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.profile, responseModel: MoviesResponse.Profile.self, completion: completion)
    }
}
