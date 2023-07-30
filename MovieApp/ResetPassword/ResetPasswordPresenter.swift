//
//  ResetPasswordPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 30.07.2023.
//

import Foundation

protocol ResetPasswordPresentationLogic: AnyObject {
    func presentResetPassword(response: ResetPasswordModels.FetchResetPassword.Response)
}

final class ResetPasswordPresenter: ResetPasswordPresentationLogic {
    
    weak var viewController: ResetPasswordDisplayLogic?
    
    func presentResetPassword(response: ResetPasswordModels.FetchResetPassword.Response) {
        let viewModel = ResetPasswordModels.FetchResetPassword.ViewModel(url: response.resetPassword.url)
        viewController?.displayResetPassword(viewModel: viewModel)
    }
}
