//
//  PaymentRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 15.07.2023.
//

import Foundation

protocol PaymentRoutingLogic: AnyObject {
    
}

protocol PaymentDataPassing: AnyObject {
    var dataStore: PaymentDataStore? { get }
}

final class PaymentRouter: PaymentRoutingLogic, PaymentDataPassing {
    
    weak var viewController: PaymentViewController?
    var dataStore: PaymentDataStore?
    
}
