//
//  SignUpWorker.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 30.07.2023.
//

import Foundation

protocol SignUpWorkingLogic: AnyObject {
    func fetchSignUp(completion: (SignUpModels.SignUp) -> Void)
}

final class SignUpWorker: SignUpWorkingLogic {
    func fetchSignUp(completion: (SignUpModels.SignUp) -> Void) {
        completion(SignUpModels.SignUp(url: "https://www.themoviedb.org/signup"))
    }
}
