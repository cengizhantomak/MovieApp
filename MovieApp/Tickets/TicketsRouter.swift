//
//  TicketsRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 18.07.2023.
//

import Foundation

protocol TicketsRoutingLogic: AnyObject {
    
}

protocol TicketsDataPassing: AnyObject {
    var dataStore: TicketsDataStore? { get }
}

final class TicketsRouter: TicketsRoutingLogic, TicketsDataPassing {
    
    weak var viewController: TicketsViewController?
    var dataStore: TicketsDataStore?
    
}
