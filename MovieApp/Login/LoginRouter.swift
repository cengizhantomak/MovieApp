//
//  LoginRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 22.07.2023.
//

import Foundation
import UIKit

protocol LoginRoutingLogic: AnyObject {
    func routeToApp()
    func routeToSignUp()
    func routeToResetPassword()
}

protocol LoginDataPassing: AnyObject {
    var dataStore: LoginDataStore? { get }
}

final class LoginRouter: LoginRoutingLogic, LoginDataPassing {
    
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    func routeToApp() {
        DispatchQueue.main.async {
            guard let tabBarController: UITabBarController = StoryboardHelper.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.tabBarController, fromStoryboard: Constants.StoryboardName.main),
                  let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let delegate = windowScene.delegate as? SceneDelegate,
                  let window = delegate.window else { return }
            
            window.rootViewController = tabBarController
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
            self.viewController?.hideLoadingView()
        }
    }
    
    func routeToSignUp() {
        guard let destinationVC: SignUpViewController = StoryboardHelper.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.signUpViewController, fromStoryboard: Constants.StoryboardName.signUp) else { return }
        
        destinationVC.loadViewIfNeeded()
        viewController?.present(destinationVC, animated: true)
    }
    
    func routeToResetPassword() {
        guard let destinationVC: ResetPasswordViewController = StoryboardHelper.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.resetPasswordViewController, fromStoryboard: Constants.StoryboardName.resetPassword) else { return }
        
        destinationVC.loadViewIfNeeded()
        viewController?.present(destinationVC, animated: true)
    }
}
