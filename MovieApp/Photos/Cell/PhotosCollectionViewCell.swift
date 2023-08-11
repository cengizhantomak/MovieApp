//
//  PhotosCollectionViewCell.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 5.07.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photosImage: UIImageView!
    
    func setCell(viewModel: PhotosModels.FethcPhotos.ViewModel.DisplayedImages) {
        if let profileUrl = ImageUrlHelper.imageUrl(for: viewModel.images) {
            photosImage.load(url: profileUrl)
        }
    }
}
