//
//  CastCrewRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 30.06.2023.
//

import Foundation

protocol CastCrewRoutingLogic: AnyObject {
    
}

protocol CastCrewDataPassing: AnyObject {
    var dataStore: CastCrewDataStore? { get }
}

final class CastCrewRouter: CastCrewRoutingLogic, CastCrewDataPassing {
    
    weak var viewController: CastCrewViewController?
    var dataStore: CastCrewDataStore?
    
}
