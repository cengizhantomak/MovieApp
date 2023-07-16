//
//  ChooseSeatRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 14.07.2023.
//

import Foundation
import UIKit

protocol ChooseSeatRoutingLogic: AnyObject {
    func routeToPayment()
}

protocol ChooseSeatDataPassing: AnyObject {
    var dataStore: ChooseSeatDataStore? { get }
}

final class ChooseSeatRouter: ChooseSeatRoutingLogic, ChooseSeatDataPassing {
    
    weak var viewController: ChooseSeatViewController?
    var dataStore: ChooseSeatDataStore?
    
    func routeToPayment() {
        let storyboard = UIStoryboard(name: "Payment", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController,
              let dataStore else { return }
        
        destinationVC.router?.dataStore?.selectedMovieTitle = dataStore.selectedMovieTitle
        destinationVC.router?.dataStore?.selectedMovieImage = dataStore.selectedMovieImage
        destinationVC.router?.dataStore?.selectedDate = dataStore.selectedDate
        destinationVC.router?.dataStore?.selectedTheater = dataStore.selectedTheater
        destinationVC.router?.dataStore?.chooseSeat = dataStore.chooseSeat
        destinationVC.router?.dataStore?.totalAmount = dataStore.totalAmount
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
