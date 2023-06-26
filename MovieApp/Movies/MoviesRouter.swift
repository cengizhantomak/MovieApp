//
//  MoviesRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation

protocol MoviesRoutingLogic: AnyObject {
    
}

protocol MoviesDataPassing: AnyObject {
    var dataStore: MoviesDataStore? { get }
}

final class MoviesRouter: MoviesRoutingLogic, MoviesDataPassing {
    
    weak var viewController: MoviesViewController?
    var dataStore: MoviesDataStore?
    
}
