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
        let storyboard = UIStoryboard(name: "MyBankCards", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "MyBankCardsViewController") as? MyBankCardsViewController,
              let dataStore,
              let myBankCardDataStore = destinationVC.router?.dataStore else { return }
        
        myBankCardDataStore.selectedMovie = MyBankCardsModels.FetchMyBankCards.ViewModel(
            originViewController: "PaymentViewController",
            selectedMovieTitle: dataStore.paymentDetails?.selectedMovieTitle,
            selectedMovieImage: dataStore.paymentDetails?.selectedMovieImage,
            selectedDate: dataStore.paymentDetails?.selectedDate,
            selectedTheater: dataStore.paymentDetails?.selectedTheater,
            chooseSeat: dataStore.paymentDetails?.chooseSeat,
            totalAmount: dataStore.paymentDetails?.totalAmount
        )
        
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
