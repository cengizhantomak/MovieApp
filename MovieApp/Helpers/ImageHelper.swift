//
//  ImageHelpers.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 1.07.2023.
//

import Foundation

import UIKit

// MARK: - UIImageView Extension
extension UIImageView {
    func load(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            }
        }.resume()
    }
}

// MARK: - ImageUrlHelper
struct ImageUrlHelper {
    static let baseImageUrl = "https://image.tmdb.org/t/p/"

    static func imageUrl(for path: String, with size: String = "w500") -> URL? {
        return URL(string: baseImageUrl + size + path)
    }
}
