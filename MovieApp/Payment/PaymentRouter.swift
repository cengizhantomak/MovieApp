//
//  PaymentRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 15.07.2023.
//

import Foundation
import UIKit

protocol PaymentRoutingLogic: AnyObject {
    func routeToAddBankCard()
    func routeToCongrats()
}

protocol PaymentDataPassing: AnyObject {
    var dataStore: PaymentDataStore? { get }
}

final class PaymentRouter: PaymentRoutingLogic, PaymentDataPassing {
    
    weak var viewController: PaymentViewController?
    var dataStore: PaymentDataStore?
    
    func routeToAddBankCard() {
        let storyboard = UIStoryboard(name: "AddBankCard", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "AddBankCardViewController") as? AddBankCardViewController else { return }
        
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToCongrats() {
        let storyboard = UIStoryboard(name: "Congrats", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "CongratsViewController") as? CongratsViewController else { return }
        
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
