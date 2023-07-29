//
//  MyBankCardsRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 21.07.2023.
//

import Foundation
import UIKit

protocol MyBankCardsRoutingLogic: AnyObject {
    func routeToAddBankCard()
    func routeToSelectBankCardPayment()
}

protocol MyBankCardsDataPassing: AnyObject {
    var dataStore: MyBankCardsDataStore? { get }
}

final class MyBankCardsRouter: MyBankCardsRoutingLogic, MyBankCardsDataPassing {
    
    weak var viewController: MyBankCardsViewController?
    var dataStore: MyBankCardsDataStore?
    
    func routeToAddBankCard() {
        let storyboard = UIStoryboard(name: "AddBankCard", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "AddBankCardViewController") as? AddBankCardViewController else { return }
        
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToSelectBankCardPayment() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
