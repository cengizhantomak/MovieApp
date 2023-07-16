//
//  AddBankCardRouter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 16.07.2023.
//

import Foundation

protocol AddBankCardRoutingLogic: AnyObject {
    
}

protocol AddBankCardDataPassing: AnyObject {
    var dataStore: AddBankCardDataStore? { get }
}

final class AddBankCardRouter: AddBankCardRoutingLogic, AddBankCardDataPassing {
    
    weak var viewController: AddBankCardViewController?
    var dataStore: AddBankCardDataStore?
    
}
