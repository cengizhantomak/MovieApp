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
        guard let destinationVC: MovieDetailsViewController = StoryboardHelper.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.movieDetailsViewController, fromStoryboard: Constants.StoryboardName.movieDetails),
              let dataStore else { return }
        destinationVC.router?.dataStore?.selectedMovieID = dataStore.selectedMovieId
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
