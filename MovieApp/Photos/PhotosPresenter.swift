//
//  PhotosPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 5.07.2023.
//

import Foundation

protocol PhotosPresentationLogic: AnyObject {
    func presentPhotos(response: PhotosModels.FethcPhotos.Response)
}

final class PhotosPresenter: PhotosPresentationLogic {
    
    weak var viewController: PhotosDisplayLogic?
    
    func presentPhotos(response: PhotosModels.FethcPhotos.Response) {
        let displayedPhotos = response.photos.map {
            PhotosModels.FethcPhotos.ViewModel.DisplayedImages(images: $0.images)
        }
        
        let viewModel = PhotosModels.FethcPhotos.ViewModel(displayedImages: displayedPhotos)
        viewController?.displayGetPhotos(viewModel: viewModel)
    }
}
