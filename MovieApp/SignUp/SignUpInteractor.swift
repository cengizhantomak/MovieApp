//
//  SignUpInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 30.07.2023.
//

import Foundation

protocol SignUpBusinessLogic: AnyObject {
    func fetchSignUp(request: SignUpModels.FetchSignUp.Request)
}

protocol SignUpDataStore: AnyObject {
    var signUp: SignUpModels.SignUp? { get set }
}

final class SignUpInteractor: SignUpBusinessLogic, SignUpDataStore {
    
    var presenter: SignUpPresentationLogic?
    var worker: SignUpWorkingLogic = SignUpWorker()
    
    var signUp: SignUpModels.SignUp?
    
    func fetchSignUp(request: SignUpModels.FetchSignUp.Request) {
        worker.fetchSignUp { signUp in
            self.signUp = signUp
            let response = SignUpModels.FetchSignUp.Response(signUp: signUp)
            presenter?.presentSignUp(response: response)
        }
    }
}
