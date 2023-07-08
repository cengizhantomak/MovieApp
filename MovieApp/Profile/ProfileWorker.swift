//
//  ProfileWorker.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 8.07.2023.
//

import Foundation

protocol ProfileWorkingLogic: AnyObject {
    func getProfile(_ completion: @escaping (Result<ProfileResponse, RequestError>) -> Void)}

final class ProfileWorker: ProfileWorkingLogic, HTTPClient {
    func getProfile(_ completion: @escaping (Result<ProfileResponse, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.profile, responseModel: ProfileResponse.self, completion: completion)
    }
}
