//
//  CollectionViewCell.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 4.07.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(viewModel: MovieDetailsModels.FetchNames.ViewModel3.DisplayedImages) {
        
        if let profileUrl = ImageUrlHelper.imageUrl(for: viewModel.images) {
            movieImage.load(url: profileUrl)
        }
    }

}
