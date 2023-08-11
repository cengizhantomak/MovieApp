//
//  UIViewController+LoadingView.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 10.08.2023.
//

import Foundation
import UIKit

extension UIViewController {
    func showLoadingView() {
        let loadingView = UIView()
        loadingView.frame = view.bounds
        loadingView.backgroundColor = UIColor(named: "theme")
        
        let imageSize = CGSize(width: 100, height: 100)
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.frame = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        imageView.center = loadingView.center
        
        loadingView.addSubview(imageView)
        view.addSubview(loadingView)
        
        // Animasyon: Resmin büyümesi ve küçülmesi
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            imageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2) // Resmi %20 büyüt
        }, completion: nil)
        
        loadingView.tag = 1234  // Sonradan referans almak için bir etiket
    }
    
    func hideLoadingView() {
        if let loadingView = view.viewWithTag(1234) {
            loadingView.removeFromSuperview()
        }
    }
}
