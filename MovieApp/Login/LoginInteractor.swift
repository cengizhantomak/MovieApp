//
//  LoginInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 22.07.2023.
//

import Foundation

protocol LoginBusinessLogic: AnyObject {
    func login(username: String?, password: String?)
}

protocol LoginDataStore: AnyObject {
    
}

final class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    
    var presenter: LoginPresentationLogic?
    var worker: LoginWorkingLogic = LoginWorker()
    
    func login(username: String?, password: String?) {
        worker.createRequestToken { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let tokenResponse):
                let token = tokenResponse.requestToken
                APIConstants.requestToken = token
                APIConstants.username = username
                APIConstants.password = password
                validateWithLogin()
            case .failure(let error):
                print(error)
                presenter?.presentLoginFailure()
            }
        }
    }
    
    func validateWithLogin() {
        worker.validateWithLogin() { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let validationResponse):
                if validationResponse.success {
                    createSession()
                } else {
                    presenter?.presentLoginFailure()
                }
            case .failure(let error):
                print(error)
                presenter?.presentLoginFailure()
            }
        }
    }
    
    func createSession() {
        worker.createSession() { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let sessionResponse):
                APIConstants.sessionId = sessionResponse.sessionId
                guard let data = sessionResponse.sessionId.data(using: .utf8) else { return }
                KeyChainHelper.shared.save(data, service: "movieDB", account: "sessionId")
//                UserDefaults.standard.set(sessionResponse.sessionId, forKey: "sessionId")
                presenter?.presentLoginSuccess()
            case .failure(let error):
                print(error)
                presenter?.presentLoginFailure()
            }
        }
    }
}
