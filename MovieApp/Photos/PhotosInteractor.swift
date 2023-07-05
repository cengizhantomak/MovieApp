//
//  PhotosInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 5.07.2023.
//

import Foundation

protocol PhotosBusinessLogic: AnyObject {
    
}

protocol PhotosDataStore: AnyObject {
    
}

final class PhotosInteractor: PhotosBusinessLogic, PhotosDataStore {
    
    var presenter: PhotosPresentationLogic?
    var worker: PhotosWorkingLogic = PhotosWorker()
    
}
