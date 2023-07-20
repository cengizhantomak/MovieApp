//
//  TicketsRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 18.07.2023.
//

import Foundation
import UIKit

protocol TicketsRoutingLogic: AnyObject {
    func routeToMap()
}

protocol TicketsDataPassing: AnyObject {
    var dataStore: TicketsDataStore? { get }
}

final class TicketsRouter: TicketsRoutingLogic, TicketsDataPassing {
    
    weak var viewController: TicketsViewController?
    var dataStore: TicketsDataStore?
    
    
    func routeToMap() {
        let storyboard = UIStoryboard(name: "Map", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else { return }
        
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
