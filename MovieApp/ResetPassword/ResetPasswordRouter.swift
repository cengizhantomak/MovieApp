//
//  ResetPasswordRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 30.07.2023.
//

import Foundation

protocol ResetPasswordRoutingLogic: AnyObject {
    
}

protocol ResetPasswordDataPassing: AnyObject {
    var dataStore: ResetPasswordDataStore? { get }
}

final class ResetPasswordRouter: ResetPasswordRoutingLogic, ResetPasswordDataPassing {
    
    weak var viewController: ResetPasswordViewController?
    var dataStore: ResetPasswordDataStore?
    
}
