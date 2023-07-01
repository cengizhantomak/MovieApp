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
        // Blur efekti oluşturuluyor
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        // Autoresizing mask ayarlanıyor
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
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


