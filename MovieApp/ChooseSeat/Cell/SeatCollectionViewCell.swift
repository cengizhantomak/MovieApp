//
//  SeatCollectionViewCell.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import UIKit

class SeatCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var textLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor(named: "47CFFF") : UIColor.clear
        }
    }
}
