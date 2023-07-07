//
//  GetTicketRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import Foundation

protocol GetTicketRoutingLogic: AnyObject {
    
}

protocol GetTicketDataPassing: AnyObject {
    var dataStore: GetTicketDataStore? { get }
}

final class GetTicketRouter: GetTicketRoutingLogic, GetTicketDataPassing {
    
    weak var viewController: GetTicketViewController?
    var dataStore: GetTicketDataStore?
    
}
