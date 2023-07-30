//
//  LinkedInRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 29.07.2023.
//

import Foundation

protocol LinkedInRoutingLogic: AnyObject {
    
}

protocol LinkedInDataPassing: AnyObject {
    var dataStore: LinkedInDataStore? { get }
}

final class LinkedInRouter: LinkedInRoutingLogic, LinkedInDataPassing {
    
    weak var viewController: LinkedInViewController?
    var dataStore: LinkedInDataStore?
    
}
