//
//  SignUpRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 30.07.2023.
//

import Foundation

protocol SignUpRoutingLogic: AnyObject {
    
}

protocol SignUpDataPassing: AnyObject {
    var dataStore: SignUpDataStore? { get }
}

final class SignUpRouter: SignUpRoutingLogic, SignUpDataPassing {
    
    weak var viewController: SignUpViewController?
    var dataStore: SignUpDataStore?
    
}
