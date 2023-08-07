//
//  MobvenVideoRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.08.2023.
//

import Foundation

protocol MobvenVideoRoutingLogic: AnyObject {
    
}

protocol MobvenVideoDataPassing: AnyObject {
    var dataStore: MobvenVideoDataStore? { get }
}

final class MobvenVideoRouter: MobvenVideoRoutingLogic, MobvenVideoDataPassing {
    
    weak var viewController: MobvenVideoViewController?
    var dataStore: MobvenVideoDataStore?
    
}
