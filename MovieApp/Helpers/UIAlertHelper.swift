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

    func showAlert(title: String?, message: String?, buttonTitle: String?, on viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
