//
//  ChooseSeatRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 14.07.2023.
//

import Foundation

protocol ChooseSeatRoutingLogic: AnyObject {
    
}

protocol ChooseSeatDataPassing: AnyObject {
    var dataStore: ChooseSeatDataStore? { get }
}

final class ChooseSeatRouter: ChooseSeatRoutingLogic, ChooseSeatDataPassing {
    
    weak var viewController: ChooseSeatViewController?
    var dataStore: ChooseSeatDataStore?
    
}
