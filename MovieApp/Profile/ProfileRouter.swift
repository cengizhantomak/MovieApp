//
//  ProfileRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 8.07.2023.
//

import Foundation

protocol ProfileRoutingLogic: AnyObject {
    
}

protocol ProfileDataPassing: AnyObject {
    var dataStore: ProfileDataStore? { get }
}

final class ProfileRouter: ProfileRoutingLogic, ProfileDataPassing {
    
    weak var viewController: ProfileViewController?
    var dataStore: ProfileDataStore?
    
}
