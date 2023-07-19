//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 3.07.2023.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var starRatingStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(viewModel: MoviesModels.FetchMovies.ViewModel.DisplayedMovie) {
        if let posterUrl = ImageUrlHelper.imageUrl(for: viewModel.posterPath) {
            posterImage.load(url: posterUrl)
        }
        
        let vote = viewModel.vote / 2
        
        if let starImages = StarRatingHelper.createStarImages(for: vote) {
            StarRatingHelper.updateStarRatingStackView(with: starImages, starSize: 14, starSpacing: 2, in: starRatingStackView)
        }
        
        titleLabel.text = viewModel.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: viewModel.releaseDate)

        dateFormatter.dateFormat = "dd MMM, yyyy"
        let formattedDate = dateFormatter.string(from: date!)

        releaseDateLabel.text = formattedDate
    }
}
