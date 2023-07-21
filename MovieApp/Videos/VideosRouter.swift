//
//  VideosRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 21.07.2023.
//

import Foundation

protocol VideosRoutingLogic: AnyObject {
    
}

protocol VideosDataPassing: AnyObject {
    var dataStore: VideosDataStore? { get }
}

final class VideosRouter: VideosRoutingLogic, VideosDataPassing {
    
    weak var viewController: VideosViewController?
    var dataStore: VideosDataStore?
    
}
