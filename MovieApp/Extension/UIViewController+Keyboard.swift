//
//  UIViewController+Keyboard.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 19.07.2023.
//

import Foundation
import UIKit

extension UIViewController {
    func setupDismissKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapView() {
        view.endEditing(true)
    }
}
