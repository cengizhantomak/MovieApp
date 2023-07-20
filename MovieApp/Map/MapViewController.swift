//
//  MapViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 20.07.2023.
//

import UIKit
import MapKit

protocol MapDisplayLogic: AnyObject {
    func displayTheatres(_ theatres: [MapModels.Theatre])
    func displayRoute(destinationCoordinate: CLLocationCoordinate2D)
}

final class MapViewController: UIViewController {
    
    var interactor: MapBusinessLogic?
    var router: (MapRoutingLogic & MapDataPassing)?
    
    // MARK: - Outlet
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Property
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        interactor?.fetchTheatres()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = MapInteractor()
        let presenter = MapPresenter()
        let router = MapRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupMapView() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.delegate = self
        locationManager.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    // MARK: - Directions Creation
    
    func createDirectionTo(destinationCoordinate: CLLocationCoordinate2D) {
        guard let sourceCoordinate = currentLocation?.coordinate else { return }
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceItem
        directionRequest.destination = destinationItem
        directionRequest.transportType = .automobile
        
        removeExistingRoutes()
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print(error)
                }
                return
            }
            
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
    }
    
    // MARK: - Removing Existing Routes
    
    func removeExistingRoutes() {
        mapView.overlays.forEach { overlay in
            mapView.removeOverlay(overlay)
        }
    }
}

// MARK: - DisplayLogic

extension MapViewController: MapDisplayLogic {
    func displayTheatres(_ theatres: [MapModels.Theatre]) {
        theatres.forEach { theatre in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: theatre.latitude, longitude: theatre.longitude)
            annotation.title = theatre.name
            mapView.addAnnotation(annotation)
        }
    }
    
    func displayRoute(destinationCoordinate: CLLocationCoordinate2D) {
        createDirectionTo(destinationCoordinate: destinationCoordinate)
    }
}

// MARK: - MKMapViewDelegate - CLLocationManagerDelegate

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "TheatrePin")
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "TheatrePin")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let destinationCoordinate = view.annotation?.coordinate,
              let annotationTitle = view.annotation?.title else { return }
        
        self.navigationItem.title = annotationTitle
        interactor?.fetchRouteToLocation(destinationCoordinate: destinationCoordinate)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.systemBlue
        renderer.lineWidth = 3.0
        return renderer
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
    }
}
