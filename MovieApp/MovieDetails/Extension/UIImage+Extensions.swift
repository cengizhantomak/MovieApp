//
//  UIImage+Extensions.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 2.07.2023.
//

import Foundation
import UIKit

extension UIImage {
    func blurred(radius: Float) -> UIImage? {
        let context = CIContext(options: nil)
        if let currentFilter = CIFilter(name: "CIGaussianBlur") {
            let beginImage = CIImage(image: self)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.setValue(radius, forKey: kCIInputRadiusKey)

            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    return UIImage(cgImage: cgimg)
                }
            }
        }
        return nil
    }
}
