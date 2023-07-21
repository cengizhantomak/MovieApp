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
}

protocol ProfileDataPassing: AnyObject {
    var dataStore: ProfileDataStore? { get }
}

final class ProfileRouter: ProfileRoutingLogic, ProfileDataPassing {
    
    weak var viewController: ProfileViewController?
    var dataStore: ProfileDataStore?
    
    func routeToMyBankCards() {
        let storyboard = UIStoryboard(name: "MyBankCards", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "MyBankCardsViewController") as? MyBankCardsViewController else { return }
        
        destinationVC.loadViewIfNeeded()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
