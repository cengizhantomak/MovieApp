//
//  MoviesRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation
import UIKit

protocol MoviesRoutingLogic: AnyObject {
    func routeToMovieDetails(with movieID: Int)
}

protocol MoviesDataPassing: AnyObject {
    var dataStore: MoviesDataStore? { get }
}

final class MoviesRouter: MoviesRoutingLogic, MoviesDataPassing {
    
    weak var viewController: MoviesViewController?
    var dataStore: MoviesDataStore?
    
    func routeToMovieDetails(with movieID: Int) {
        let storyboard = UIStoryboard(name: "MovieDetails", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController,
              let sourceVC = viewController else { return }
        
        destinationVC.router?.dataStore?.selectedMovieID = movieID
        destinationVC.loadViewIfNeeded()
        sourceVC.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
