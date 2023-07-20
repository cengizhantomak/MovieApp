//
//  MapPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 20.07.2023.
//

import Foundation
import MapKit

protocol MapPresentationLogic: AnyObject {
    func presentTheatres(_ theatres: [MapModels.Theatre])
    func presentRoute(destinationCoordinate: CLLocationCoordinate2D)
}

final class MapPresenter: MapPresentationLogic {
    
    weak var viewController: MapDisplayLogic?
    
    func presentTheatres(_ theatres: [MapModels.Theatre]) {
        viewController?.displayTheatres(theatres)
    }
    
    func presentRoute(destinationCoordinate: CLLocationCoordinate2D) {
        viewController?.displayRoute(destinationCoordinate: destinationCoordinate)
    }
}
