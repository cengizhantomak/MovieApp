//
//  MyBankCardsCollectionViewCell.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 21.07.2023.
//

import UIKit

class MyBankCardsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardHolderLabel: UILabel!
    @IBOutlet weak var expiresLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(viewModel: MyBankCardsModels.FetchMyBankCards.ViewModel.DisplayedBankCard) {
        cardNumberLabel.text = viewModel.cardNumber
        cardHolderLabel.text = viewModel.cardHolder
        expiresLabel.text = viewModel.cardExpires
    }
}
