//
//  ResetPasswordInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 30.07.2023.
//

import Foundation

protocol ResetPasswordBusinessLogic: AnyObject {
    func fetchResetPassword(request: ResetPasswordModels.FetchResetPassword.Request)
}

protocol ResetPasswordDataStore: AnyObject {
    var resetPassword: ResetPasswordModels.ResetPassword? { get set }
}

final class ResetPasswordInteractor: ResetPasswordBusinessLogic, ResetPasswordDataStore {
    
    var presenter: ResetPasswordPresentationLogic?
    var worker: ResetPasswordWorkingLogic = ResetPasswordWorker()
    
    var resetPassword: ResetPasswordModels.ResetPassword?
    
    func fetchResetPassword(request: ResetPasswordModels.FetchResetPassword.Request) {
        worker.fetchResetPassword { resetPassword in
            self.resetPassword = resetPassword
            let response = ResetPasswordModels.FetchResetPassword.Response(resetPassword: resetPassword)
            presenter?.presentResetPassword(response: response)
        }
    }
}
