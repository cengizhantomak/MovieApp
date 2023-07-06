//
//  WatchlistRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import Foundation
import UIKit

protocol WatchlistRoutingLogic: AnyObject {
    func routeToMovieDetails()
}

protocol WatchlistDataPassing: AnyObject {
    var dataStore: WatchlistDataStore? { get }
}

final class WatchlistRouter: WatchlistRoutingLogic, WatchlistDataPassing {
    
    weak var viewController: WatchlistViewController?
    var dataStore: WatchlistDataStore?
    
    func routeToMovieDetails() {
        let storyboard = UIStoryboard(name: "MovieDetails", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController,
        let dataStore else { return }
        
        destinationVC.router?.dataStore?.selectedMovieID = dataStore.selectedMovieId
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
