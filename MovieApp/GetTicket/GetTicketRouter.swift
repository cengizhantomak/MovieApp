//
//  GetTicketRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import Foundation
import UIKit

protocol GetTicketRoutingLogic: AnyObject {
    func routeToChooseSeat()
}

protocol GetTicketDataPassing: AnyObject {
    var dataStore: GetTicketDataStore? { get }
}

final class GetTicketRouter: GetTicketRoutingLogic, GetTicketDataPassing {
    
    weak var viewController: GetTicketViewController?
    var dataStore: GetTicketDataStore?
    
    func routeToChooseSeat() {
        let storyboard = UIStoryboard(name: "ChooseSeat", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "ChooseSeatViewController") as? ChooseSeatViewController,
              let dataStore,
              let chooseSeatDataStore = destinationVC.router?.dataStore else { return }
        
        chooseSeatDataStore.seatDetails = ChooseSeatModels.FetchChooseSeat.ViewModel(
            selectedMovieTitle: dataStore.ticketDetails?.selectedMovieTitle,
            selectedMovieImage: dataStore.ticketDetails?.selectedMovieImage,
            selectedDate: dataStore.ticketDetails?.selectedDate,
            selectedTheater: dataStore.ticketDetails?.selectedTheater
        )
        
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
