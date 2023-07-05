//
//  PhotosCollectionViewCell.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 5.07.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photosImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(viewModel: MovieDetailsModels.FetchNames.ViewModel3.DisplayedImages) {
        
        if let profileUrl = ImageUrlHelper.imageUrl(for: viewModel.images) {
            photosImage.load(url: profileUrl)
        }
    }

}
