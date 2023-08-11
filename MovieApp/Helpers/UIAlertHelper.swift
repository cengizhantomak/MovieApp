//
//  UIAlertHelper.swift
//  MovieApp
//
//  Created by Kerem Tuna Tomak on 11.07.2023.
//

import Foundation
import UIKit

class UIAlertHelper {

    static let shared = UIAlertHelper()
    private init() {}

    func showAlert(title: String?, message: String?, buttonTitle: String?, on viewController: UIViewController, buttonAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
            buttonAction?()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }

    func showTwoButtonAlert(title: String?, message: String?, buttonOneTitle: String?, buttonTwoTitle: String?, on viewController: UIViewController, buttonOneAction: (() -> Void)? = nil, buttonTwoAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonOneTitle, style: .default, handler: { _ in
            buttonOneAction?()
        }))
        alert.addAction(UIAlertAction(title: buttonTwoTitle, style: .default, handler: { _ in
            buttonTwoAction?()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
}
