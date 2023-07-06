//
//  UIImageView+Extensions.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 1.07.2023.
//

import Foundation
import UIKit

extension UIView {
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.alpha = 0.9
        
        self.addSubview(blurEffectView)
    }
    
    @IBInspectable var cornerRadiusForView: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}


