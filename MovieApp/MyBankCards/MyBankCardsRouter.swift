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
        guard let destinationVC: AddBankCardViewController = StoryboardHelper.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.addBankCardViewController, fromStoryboard: Constants.StoryboardName.addBankCard) else { return }
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToSelectBankCardPayment() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
