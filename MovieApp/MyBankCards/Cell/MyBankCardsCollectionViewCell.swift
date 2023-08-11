//
//  MyBankCardsCollectionViewCell.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 21.07.2023.
//

import UIKit

protocol MyBankCardsCollectionViewCellDelegate: AnyObject {
    func didPressCancel(id: UUID)
}

class MyBankCardsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardHolderLabel: UILabel!
    @IBOutlet weak var expiresLabel: UILabel!
    
    weak var delegate: MyBankCardsCollectionViewCellDelegate?
    var id: UUID?
    
    func setCell(viewModel: MyBankCardsModels.FetchMyBankCards.ViewModel.DisplayedBankCard) {
        cardNumberLabel.text = viewModel.cardNumber
        cardHolderLabel.text = viewModel.cardHolder
        expiresLabel.text = viewModel.cardExpires
        id = viewModel.id
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        if let id = id {
            delegate?.didPressCancel(id: id)
        }
    }
}
