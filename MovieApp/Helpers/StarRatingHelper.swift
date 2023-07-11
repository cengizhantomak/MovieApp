//
//  StarRatingHelper.swift
//  MovieApp
//
//  Created by Kerem Tuna Tomak on 11.07.2023.
//

import Foundation
import UIKit

class StarRatingHelper {
    static func createStarImages(for vote: Float) -> [UIImage]? {
        let fullStars = Int(vote)
        let halfStar = vote - Float(fullStars)
        
        let fullStarImage = UIImage(systemName: "star.fill")
        let halfStarImage = UIImage(systemName: "star.leadinghalf.filled")
        let emptyStarImage = UIImage(systemName: "star")
        
        if fullStarImage == nil || halfStarImage == nil || emptyStarImage == nil {
            print("Failed to generate star images.")
            return nil
        }
        
        let starImages: [UIImage] = (0..<5).map { index in
            if index < fullStars {
                return fullStarImage!
            } else if index == fullStars && halfStar >= 0.5 {
                return halfStarImage!
            } else {
                return emptyStarImage!
            }
        }
        
        return starImages
    }
    
    static func updateStarRatingStackView(with starImages: [UIImage], starSize: CGFloat, starSpacing: CGFloat, in stackView: UIStackView) {
        DispatchQueue.main.async {
            stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            
            starImages.forEach { image in
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                stackView.addArrangedSubview(imageView)
                stackView.spacing = starSpacing
                imageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    imageView.heightAnchor.constraint(equalToConstant: starSize),
                    imageView.widthAnchor.constraint(equalToConstant: starSize)
                ])
            }
        }
    }
}
