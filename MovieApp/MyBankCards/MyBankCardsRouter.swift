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
        let storyboard = UIStoryboard(name: "Payment", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController,
              let dataStore = dataStore,
              let paymentDataStore = destinationVC.router?.dataStore,
              let selectedMovie = dataStore.selectedMovie,
              let selectedBankCard = dataStore.selectedBankCard else { return }
        
        paymentDataStore.paymentDetails = PaymentModels.FetchPayment.ViewModel(
            selectedMovieTitle: selectedMovie.selectedMovieTitle,
            selectedMovieImage: selectedMovie.selectedMovieImage,
            selectedDate: selectedMovie.selectedDate,
            selectedTime: selectedMovie.selectedTime,
            selectedTheater: selectedMovie.selectedTheater,
            chooseSeat: selectedMovie.chooseSeat,
            totalAmount: selectedMovie.totalAmount,
            cardNumber: selectedBankCard.cardNumber,
            cardHolder: selectedBankCard.cardHolder,
            cardExpires: selectedBankCard.cardExpires,
            cvv: selectedBankCard.cvv,
            id: selectedBankCard.id
        )
        
        guard let viewController = viewController,
              let navigationController = viewController.navigationController,
              let index = navigationController.viewControllers.firstIndex(of: viewController),
              index > 0,
              let previousVC = navigationController.viewControllers[index - 1] as? PaymentViewController,
              let paymentDetails = paymentDataStore.paymentDetails else { return }
        
        previousVC.interactor?.updatePaymentDetails(with: paymentDetails)
        
        navigationController.popViewController(animated: true)
    }
}
