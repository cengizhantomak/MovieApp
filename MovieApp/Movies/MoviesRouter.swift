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
        
//        let storyboard = UIStoryboard(name: "MovieDetails", bundle: nil)
//        if let movieDetailsVC = storyboard.instantiateInitialViewController() as? MovieDetailsViewController {
//            print("route: \(movieID)")
//            movieDetailsVC.loadViewIfNeeded()
//            movieDetailsVC.router?.dataStore?.movieID = movieID
//            viewController?.navigationController?.pushViewController(movieDetailsVC, animated: true)
//        }
        
//        if let movieDetailVC = UIStoryboard(name: "MovieDetails", bundle: .main).instantiateInitialViewController() as? MovieDetailsViewController {
//            movieDetailVC.loadViewIfNeeded()
//            movieDetailVC.router?.dataStore?.movieID = movieID
//            viewController?.navigationController?.pushViewController(movieDetailVC, animated: true)
//        }
        
        let storyboard = UIStoryboard(name: "MovieDetails", bundle: nil)
//        let destinationVC: MovieDetailsViewController = storyboard.instantiateViewController(identifier: "MovieDetailsViewController")
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else { return }
        
        destinationVC.router?.dataStore?.movieID = movieID
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
