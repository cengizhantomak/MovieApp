//
//  PaymentRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 15.07.2023.
//

import Foundation
import UIKit

protocol PaymentRoutingLogic: AnyObject {
    func routeToMyBankCards()
    func routeToCongrats()
}

protocol PaymentDataPassing: AnyObject {
    var dataStore: PaymentDataStore? { get }
}

final class PaymentRouter: PaymentRoutingLogic, PaymentDataPassing {
    
    weak var viewController: PaymentViewController?
    var dataStore: PaymentDataStore?
    
    func routeToMyBankCards() {
        guard let destinationVC: MyBankCardsViewController = StoryboardHelper.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.myBankCardsViewController, fromStoryboard: Constants.StoryboardName.myBankCards),
              let myBankCardDataStore = destinationVC.router?.dataStore else { return }
        
        myBankCardDataStore.selectedMovie = MyBankCardsModels.FetchMyBankCards.ViewModel(originViewController: Constants.StoryboardIdentifier.paymentViewController)
        
        destinationVC.delegate = self
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToCongrats() {
        guard let destinationVC: CongratsViewController = StoryboardHelper.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.congratsViewController, fromStoryboard: Constants.StoryboardName.congrats) else { return }
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}

extension PaymentRouter: selectionBankCardDelegate {
    func getBankCardData(nameCard: String?, cardNumber: String?, dateExpire: String?, cvv: String?) {
        dataStore?.paymentDetails?.cardHolder = nameCard
        dataStore?.paymentDetails?.cardNumber = cardNumber
        dataStore?.paymentDetails?.cardExpires = dateExpire
        dataStore?.paymentDetails?.cvv = cvv
    }
}
