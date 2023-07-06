//
//  PhotosInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 5.07.2023.
//

import Foundation

protocol PhotosBusinessLogic: AnyObject {
    func getPhotos()
}

protocol PhotosDataStore: AnyObject {
    var allPhotos: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedImages] {get set}
}

final class PhotosInteractor: PhotosBusinessLogic, PhotosDataStore {
    
    var presenter: PhotosPresentationLogic?
    var worker: PhotosWorkingLogic = PhotosWorker()
    
    var allPhotos: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedImages] = []
    
    func getPhotos() {
        let response = PhotosModels.FethcPhotos.Response(photos: allPhotos)
        presenter?.presentPhotos(response: response)
    }
}
