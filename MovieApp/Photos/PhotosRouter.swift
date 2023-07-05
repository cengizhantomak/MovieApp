//
//  PhotosRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 5.07.2023.
//

import Foundation

protocol PhotosRoutingLogic: AnyObject {
    
}

protocol PhotosDataPassing: AnyObject {
    var dataStore: PhotosDataStore? { get }
}

final class PhotosRouter: PhotosRoutingLogic, PhotosDataPassing {
    
    weak var viewController: PhotosViewController?
    var dataStore: PhotosDataStore?
    
}
