//
//  MapInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 20.07.2023.
//

import Foundation
import MapKit

protocol MapBusinessLogic: AnyObject {
    func fetchTheatres()
    func fetchRouteToLocation(destinationCoordinate: CLLocationCoordinate2D)
}

protocol MapDataStore: AnyObject {
    
}

final class MapInteractor: MapBusinessLogic, MapDataStore {
    
    var presenter: MapPresentationLogic?
    var worker: MapWorkingLogic = MapWorker()
    
    
    func fetchTheatres() {
        let theatres = MapModels.TheatreData.theatres
        presenter?.presentTheatres(theatres)
    }
    
    func fetchRouteToLocation(destinationCoordinate: CLLocationCoordinate2D) {
        presenter?.presentRoute(destinationCoordinate: destinationCoordinate)
    }
}
