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
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController,
                  let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let delegate = windowScene.delegate as? SceneDelegate,
                  let window = delegate.window else { return }
            
            window.rootViewController = tabBarController
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
            self.viewController?.hideLoadingView()
        }
    }
    
    func routeToSignUp() {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        
        destinationVC.loadViewIfNeeded()
        viewController?.present(destinationVC, animated: true)
    }
    
    func routeToResetPassword() {
        let storyboard = UIStoryboard(name: "ResetPassword", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "ResetPasswordViewController") as? ResetPasswordViewController else { return }
        
        destinationVC.loadViewIfNeeded()
        viewController?.present(destinationVC, animated: true)
    }
}
