//
//  TicketsCollectionViewCell.swift
//  MovieApp
//
//  Created by Kerem Tuna Tomak on 18.07.2023.
//

import UIKit

class TicketsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var theatre: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var seat: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(viewModel: TicketsModels.FetchTickets.ViewModel.DisplayedTicket) {
        if let profileUrl = ImageUrlHelper.imageUrl(for: viewModel.imagePath) {
            posterImage.load(url: profileUrl)
        }
        
        title.text = viewModel.title
        theatre.text = viewModel.theatre
        date.text = viewModel.date
        seat.text = viewModel.seat
    }
}
