//
//  CongratsRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 17.07.2023.
//

import Foundation
import UIKit

protocol CongratsRoutingLogic: AnyObject {
    func routeTo()
}

protocol CongratsDataPassing: AnyObject {
    var dataStore: CongratsDataStore? { get }
}

final class CongratsRouter: CongratsRoutingLogic, CongratsDataPassing {
    
    weak var viewController: CongratsViewController?
    var dataStore: CongratsDataStore?
    
    func routeTo() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
