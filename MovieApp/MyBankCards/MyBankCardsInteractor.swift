//
//  MyBankCardsInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 21.07.2023.
//

import Foundation
import UIKit

protocol MyBankCardsBusinessLogic: AnyObject {
    func fetchBankCards(request: MyBankCardsModels.FetchMyBankCards.Request)
}

protocol MyBankCardsDataStore: AnyObject {
    
}

final class MyBankCardsInteractor: MyBankCardsBusinessLogic, MyBankCardsDataStore {
    
    var presenter: MyBankCardsPresentationLogic?
    var worker: MyBankCardsWorkingLogic = MyBankCardsWorker()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchBankCards(request: MyBankCardsModels.FetchMyBankCards.Request) {
        do {
            let bankCards = try worker.fetchBankCards(using: context)
            let response = MyBankCardsModels.FetchMyBankCards.Response(bankCards: bankCards)
            presenter?.presentTickets(response: response)
        } catch {
            print("Failed to fetch tickets: \(error)")
        }
    }
}
