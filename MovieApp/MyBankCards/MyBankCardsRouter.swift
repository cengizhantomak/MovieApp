//
//  MyBankCardsRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 21.07.2023.
//

import Foundation

protocol MyBankCardsRoutingLogic: AnyObject {
    
}

protocol MyBankCardsDataPassing: AnyObject {
    var dataStore: MyBankCardsDataStore? { get }
}

final class MyBankCardsRouter: MyBankCardsRoutingLogic, MyBankCardsDataPassing {
    
    weak var viewController: MyBankCardsViewController?
    var dataStore: MyBankCardsDataStore?
    
}
