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
    func deleteBankCard(request: MyBankCardsModels.DeleteBankCard.Request)
//    func selectBankCard(bankCardDetail: MyBankCardsModels.FetchMyBankCards.ViewModel.DisplayedBankCard?)
    func getOriginViewController()
}

protocol MyBankCardsDataStore: AnyObject {
    var selectedBankCard: MyBankCardsModels.FetchMyBankCards.ViewModel.DisplayedBankCard? { get set }
    var originViewController: String? { get set }
    var selectedMovie: MyBankCardsModels.FetchMyBankCards.ViewModel? { get set }
}

final class MyBankCardsInteractor: MyBankCardsBusinessLogic, MyBankCardsDataStore {
    
    var presenter: MyBankCardsPresentationLogic?
    var worker: MyBankCardsWorkingLogic = MyBankCardsWorker()
    
    var selectedBankCard: MyBankCardsModels.FetchMyBankCards.ViewModel.DisplayedBankCard?
    var originViewController: String?
    var selectedMovie: MyBankCardsModels.FetchMyBankCards.ViewModel?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchBankCards(request: MyBankCardsModels.FetchMyBankCards.Request) {
        do {
            let bankCards = try worker.fetchBankCards(using: context)
            let response = MyBankCardsModels.FetchMyBankCards.Response(bankCards: bankCards)
            presenter?.presentBankCards(response: response)
        } catch {
            print("Failed to fetch tickets: \(error)")
        }
    }
    
    func deleteBankCard(request: MyBankCardsModels.DeleteBankCard.Request) {
        do {
            try worker.deleteBankCard(withId: request.bankCardId, using: context)
            fetchBankCards(request: MyBankCardsModels.FetchMyBankCards.Request())
        } catch {
            print("Failed to delete ticket: \(error)")
        }
    }
    
//    func selectBankCard(bankCardDetail: MyBankCardsModels.FetchMyBankCards.ViewModel.DisplayedBankCard?) {
//        selectedBankCard = bankCardDetail
//        presenter?.presentSelectBankCard()
//    }
    
    func getOriginViewController() {
        guard let selectedMovie else { return }
        presenter?.presentOriginViewController(originViewController: selectedMovie.originViewController)
    }
}
