//
//  MovieDetailsRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import Foundation
import UIKit

protocol MovieDetailsRoutingLogic: AnyObject {
    func routeToPhotos()
    func routeToCastCrew()
    func routeToGetTicket()
    func routeToWatchList()
    func routeToVideos()
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
              let dataStore else {
            return
        }
        
        destinationVC.router?.dataStore?.allCast = dataStore.allCast
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToPhotos() {
        let storyboard = UIStoryboard(name: "Photos", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "PhotosViewController") as? PhotosViewController,
              let dataStore else {
            return
        }
        
        destinationVC.router?.dataStore?.allPhotos = dataStore.allPhotos
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToVideos() {
        let storyboard = UIStoryboard(name: "Videos", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "VideosViewController") as? VideosViewController,
              let dataStore,
              let getTicketDataStore = destinationVC.router?.dataStore else { return }
        
        getTicketDataStore.selectedMovieID = dataStore.selectedMovieID
        
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToGetTicket() {
        let storyboard = UIStoryboard(name: "GetTicket", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "GetTicketViewController") as? GetTicketViewController,
              let dataStore,
              let getTicketDataStore = destinationVC.router?.dataStore else { return }
        
        getTicketDataStore.ticketDetails = GetTicketModels.FetchGetTicket.ViewModel(
            selectedMovieTitle: dataStore.selectedMovieTitle,
            selectedMovieImage: dataStore.selectedMovieImage
        )
        
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToWatchList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "WatchlistViewController") as? WatchlistViewController else { return }
        
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
