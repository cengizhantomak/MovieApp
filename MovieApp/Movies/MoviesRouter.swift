//
//  MoviesRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation
import UIKit

protocol MoviesRoutingLogic: AnyObject {
    func routeToMovieDetails()
}

protocol MoviesDataPassing: AnyObject {
    var dataStore: MoviesDataStore? { get }
}

final class MoviesRouter: MoviesRoutingLogic, MoviesDataPassing {
    
    weak var viewController: MoviesViewController?
    var dataStore: MoviesDataStore?
    
    func routeToMovieDetails() {
        guard let destinationVC: MovieDetailsViewController = StoryboardHelper.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.movieDetailsViewController, fromStoryboard: Constants.StoryboardName.movieDetails),
              let dataStore else { return }
        destinationVC.router?.dataStore?.selectedMovieID = dataStore.selectedMovieId
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
