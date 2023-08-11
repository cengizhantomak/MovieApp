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
        guard let destinationVC: CastCrewViewController = StoryboardHelper.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.castCrewViewController, fromStoryboard: Constants.StoryboardName.castCrew),
              let dataStore,
              let castCrewDataStore = destinationVC.router?.dataStore else { return }
        
        castCrewDataStore.allCast = dataStore.allCast
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToPhotos() {
        guard let destinationVC: PhotosViewController = StoryboardHelper.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.photosViewController, fromStoryboard: Constants.StoryboardName.photos),
              let dataStore,
              let photosDataStore = destinationVC.router?.dataStore else { return }
        
        photosDataStore.allPhotos = dataStore.allPhotos
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToVideos() {
        guard let destinationVC: VideosViewController = StoryboardHelper.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.videosViewController, fromStoryboard: Constants.StoryboardName.videos),
              let dataStore,
              let videosDataStore = destinationVC.router?.dataStore else { return }
        
        videosDataStore.selectedMovieID = dataStore.selectedMovieID
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToGetTicket() {
        guard let destinationVC: GetTicketViewController = StoryboardHelper.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.getTicketViewController, fromStoryboard: Constants.StoryboardName.getTicket),
              let dataStore,
              let getTicketDataStore = destinationVC.router?.dataStore else { return }
        
        getTicketDataStore.ticketDetails = GetTicketModels.FetchGetTicket.ViewModel(
            selectedMovieTitle: dataStore.selectedMovieTitle,
            selectedMovieImage: dataStore.selectedMovieImage)
        
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToWatchList() {
        guard let destinationVC: WatchlistViewController = StoryboardHelper.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.watchlistViewController, fromStoryboard: Constants.StoryboardName.main) else { return }
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
