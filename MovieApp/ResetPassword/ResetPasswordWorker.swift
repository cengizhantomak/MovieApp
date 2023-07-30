//
//  ResetPasswordWorker.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 30.07.2023.
//

import Foundation

protocol ResetPasswordWorkingLogic: AnyObject {
    func fetchResetPassword(completion: (ResetPasswordModels.ResetPassword) -> Void)
}

final class ResetPasswordWorker: ResetPasswordWorkingLogic {
    func fetchResetPassword(completion: (ResetPasswordModels.ResetPassword) -> Void) {
        completion(ResetPasswordModels.ResetPassword(url: "https://www.themoviedb.org/reset-password"))
    }
}
