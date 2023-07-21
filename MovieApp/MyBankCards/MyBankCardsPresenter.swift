//
//  MyBankCardsPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 21.07.2023.
//

import Foundation

protocol MyBankCardsPresentationLogic: AnyObject {
    func presentTickets(response: MyBankCardsModels.FetchMyBankCards.Response)
}

final class MyBankCardsPresenter: MyBankCardsPresentationLogic {
    
    weak var viewController: MyBankCardsDisplayLogic?
    
    func presentTickets(response: MyBankCardsModels.FetchMyBankCards.Response) {
        let displayedBankCards = response.bankCards.compactMap { bankCard in
            MyBankCardsModels.FetchMyBankCards.ViewModel.DisplayedBankCard(
                cardNumber: bankCard.cardNumber ?? "",
                cardHolder: bankCard.nameCard ?? "",
                cardExpires: bankCard.dateExpire ?? ""
            )
        }
        
        let viewModel = MyBankCardsModels.FetchMyBankCards.ViewModel(displayedBankCard: displayedBankCards)
        viewController?.displayBankCards(viewModel: viewModel)
    }
}
