//
//  MovieDetailsRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation
import UIKit

protocol MovieDetailsRoutingLogic: AnyObject {
    func routeToCastCrew()
    func routeToPhotos()
}

protocol MovieDetailsDataPassing: AnyObject {
    var dataStore: MovieDetailsDataStore? { get }
}

final class MovieDetailsRouter: MovieDetailsRoutingLogic, MovieDetailsDataPassing {
    
    weak var viewController: MovieDetailsViewController?
    var dataStore: MovieDetailsDataStore?
    
    func routeToCastCrew() {
        let storyboard = UIStoryboard(name: "CastCrew", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "CastCrewViewController") as? CastCrewViewController,
              let sourceVC = viewController else {
            return
        }
        
        destinationVC.allCast = sourceVC.displayedNames
        destinationVC.loadViewIfNeeded()
        sourceVC.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToPhotos() {
        let storyboard = UIStoryboard(name: "Photos", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "PhotosViewController") as? PhotosViewController,
              let sourceVC = viewController else {
            return
        }
        
        destinationVC.displayedPhotos = sourceVC.displayedImages
        destinationVC.loadViewIfNeeded()
        sourceVC.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
