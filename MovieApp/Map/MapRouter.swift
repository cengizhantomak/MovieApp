//
//  MapRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 20.07.2023.
//

import Foundation

protocol MapRoutingLogic: AnyObject {
    
}

protocol MapDataPassing: AnyObject {
    var dataStore: MapDataStore? { get }
}

final class MapRouter: MapRoutingLogic, MapDataPassing {
    
    weak var viewController: MapViewController?
    var dataStore: MapDataStore?
    
}
