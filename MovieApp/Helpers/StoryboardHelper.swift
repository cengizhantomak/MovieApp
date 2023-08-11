//
//  StoryboardHelper.swift
//  MovieApp
//
//  Created by Kerem Tuna Tomak on 10.08.2023.
//

import Foundation
import UIKit

struct StoryboardHelper {
    static func instantiateViewController<T: UIViewController>(withIdentifier identifier: String, fromStoryboard storyboardName: String) -> T? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as? T
    }
}
