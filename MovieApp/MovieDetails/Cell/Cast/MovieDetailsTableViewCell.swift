//
//  MovieDetailsTableViewCell.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import UIKit

class MovieDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var creditsImage: UIImageView!
    @IBOutlet weak var creditsNameLabel: UILabel!
    @IBOutlet weak var creditsCharNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(viewModel: MovieDetailsModels.FetchNames.ViewModel.DisplayedCast) {
        creditsNameLabel.text = viewModel.name
        creditsCharNameLabel.text = viewModel.character.uppercased()
    }
    
}
