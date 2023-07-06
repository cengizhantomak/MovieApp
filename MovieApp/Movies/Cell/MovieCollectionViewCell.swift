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
        
        let fullStars = Int(vote)
        let halfStar = vote - Float(fullStars)
        var starImages: [UIImage] = []
        let fullStarImage = UIImage(systemName: "star.fill")
        let halfStarImage = UIImage(systemName: "star.leadinghalf.filled")
        let emptyStarImage = UIImage(systemName: "star")
        
        starImages.reserveCapacity(5)
        
        for i in 0..<5 {
            let starImage: UIImage
            
            if i < fullStars {
                starImage = fullStarImage!
            } else if i == fullStars && halfStar >= 0.5 {
                starImage = halfStarImage!
            } else {
                starImage = emptyStarImage!
            }
            
            starImages.append(starImage)
        }
        
        starRatingStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for image in starImages {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            starRatingStackView.addArrangedSubview(imageView)
            starRatingStackView.spacing = 2
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalToConstant: 14),
                imageView.widthAnchor.constraint(equalToConstant: 14)
            ])
        }
        
        titleLabel.text = viewModel.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: viewModel.releaseDate)

        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = dateFormatter.string(from: date!)

        releaseDateLabel.text = formattedDate
    }
}
