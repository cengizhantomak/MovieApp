//
//  SignUpPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 30.07.2023.
//

import Foundation

protocol SignUpPresentationLogic: AnyObject {
    func presentSignUp(response: SignUpModels.FetchSignUp.Response)
}

final class SignUpPresenter: SignUpPresentationLogic {
    
    weak var viewController: SignUpDisplayLogic?
    
    func presentSignUp(response: SignUpModels.FetchSignUp.Response) {
        let viewModel = SignUpModels.FetchSignUp.ViewModel(url: response.signUp.url)
        viewController?.displaySignUp(viewModel: viewModel)
    }
}
