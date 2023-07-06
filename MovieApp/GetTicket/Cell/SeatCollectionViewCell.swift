//
//  SeatCollectionViewCell.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import UIKit

class SeatCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var seatView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        seatView.layer.borderWidth = 1
        seatView.layer.borderColor = UIColor.systemGray2.cgColor
    }

}
