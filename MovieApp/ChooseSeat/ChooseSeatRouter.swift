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
    func routeToBack()
}

protocol ChooseSeatDataPassing: AnyObject {
    var dataStore: ChooseSeatDataStore? { get }
}

final class ChooseSeatRouter: ChooseSeatRoutingLogic, ChooseSeatDataPassing {
    
    weak var viewController: ChooseSeatViewController?
    var dataStore: ChooseSeatDataStore?
    
    func routeToPayment() {
        guard let destinationVC: PaymentViewController = StoryboardHelper.instantiateViewController(withIdentifier: "PaymentViewController", fromStoryboard: "Payment"),
              let dataStore,
              let paymentDataStore = destinationVC.router?.dataStore else { return }
        
        paymentDataStore.paymentDetails = PaymentModels.FetchPayment.ViewModel(
            selectedMovieTitle: dataStore.seatDetails?.selectedMovieTitle,
            selectedMovieImage: dataStore.seatDetails?.selectedMovieImage,
            selectedDate: dataStore.seatDetails?.selectedDate,
            selectedTime: dataStore.seatDetails?.selectedTime,
            selectedTheater: dataStore.seatDetails?.selectedTheater,
            chooseSeat: dataStore.seatDetails?.chooseSeat,
            totalAmount: dataStore.seatDetails?.totalAmount)
        
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
