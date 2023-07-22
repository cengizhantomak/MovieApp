//
//  LoginPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 22.07.2023.
//

import Foundation

protocol LoginPresentationLogic: AnyObject {
    func presentLoginSuccess()
    func presentLoginFailure()
}

final class LoginPresenter: LoginPresentationLogic {
    
    weak var viewController: LoginDisplayLogic?
    
    func presentLoginSuccess() {
        viewController?.displayLoginSuccess()
    }
    
    func presentLoginFailure() {
        viewController?.displayLoginFailure()
    }
}
