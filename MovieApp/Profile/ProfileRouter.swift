//
//  ProfileRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 8.07.2023.
//

import Foundation
import UIKit

protocol ProfileRoutingLogic: AnyObject {
    func routeToMyBankCards()
    func routeToLinkedIn()
    func routeToMobvenVideo()
    func routeToLoginScreen()
}

protocol ProfileDataPassing: AnyObject {
    var dataStore: ProfileDataStore? { get }
}

final class ProfileRouter: ProfileRoutingLogic, ProfileDataPassing {
    
    weak var viewController: ProfileViewController?
    var dataStore: ProfileDataStore?
    
    func routeToMyBankCards() {
        guard let destinationVC: MyBankCardsViewController = StoryboardHelper.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.myBankCardsViewController, fromStoryboard: Constants.StoryboardName.myBankCards) else { return }
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToLinkedIn() {
        guard let destinationVC: LinkedInViewController = StoryboardHelper.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.linkedInViewController, fromStoryboard: Constants.StoryboardName.linkedIn) else { return }
        destinationVC.hidesBottomBarWhenPushed = true
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToMobvenVideo() {
        guard let destinationVC: MobvenVideoViewController = StoryboardHelper.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.mobvenVideoViewController, fromStoryboard: Constants.StoryboardName.mobvenVideo) else { return }
        destinationVC.hidesBottomBarWhenPushed = true
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func routeToLoginScreen() {
        guard let loginVC: LoginViewController = StoryboardHelper.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.loginViewController, fromStoryboard: Constants.StoryboardName.main),
              let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        window.rootViewController = loginVC
        window.makeKeyAndVisible()
    }
}
