//
//  LoginWorker.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 22.07.2023.
//

import Foundation

protocol LoginWorkingLogic: AnyObject {
    func createRequestToken(_ completion: @escaping (Result<LoginResponse.TokenResponse, RequestError>) -> Void)
    func validateWithLogin(_ completion: @escaping (Result<LoginResponse.TokenValidationResponse, RequestError>) -> Void)
    func createSession(_ completion: @escaping (Result<LoginResponse.SessionResponse, RequestError>) -> Void)
}

final class LoginWorker: LoginWorkingLogic, HTTPClient {
    func createRequestToken(_ completion: @escaping (Result<LoginResponse.TokenResponse, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.createRequestToken, responseModel: LoginResponse.TokenResponse.self, completion: completion)
    }
    
    func validateWithLogin(_ completion: @escaping (Result<LoginResponse.TokenValidationResponse, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.validateWithLogin, responseModel: LoginResponse.TokenValidationResponse.self, completion: completion)
    }
    
    func createSession( _ completion: @escaping (Result<LoginResponse.SessionResponse, RequestError>) -> Void) {
        sendRequest(endpoint: MoviesEndpoint.createSession, responseModel: LoginResponse.SessionResponse.self, completion: completion)
    }
}
