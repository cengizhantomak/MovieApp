//
//  TicketsCollectionViewCell.swift
//  MovieApp
//
//  Created by Kerem Tuna Tomak on 18.07.2023.
//

import UIKit

protocol TicketsCollectionViewCellDelegate: AnyObject {
    func didPressCancel(id: UUID)
}

class TicketsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var theatreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var seatLabel: UILabel!
    
    weak var delegate: TicketsCollectionViewCellDelegate?
    var id: UUID?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(viewModel: TicketsModels.FetchTickets.ViewModel.DisplayedTicket) {
        if let profileUrl = ImageUrlHelper.imageUrl(for: viewModel.imagePath) {
            posterImage.load(url: profileUrl)
        }
        
        titleLabel.text = viewModel.title
        theatreLabel.text = viewModel.theatre
        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
        seatLabel.text = viewModel.seat
        
        id = viewModel.id
    }
    
    @IBAction func iptalEt(_ sender: Any) {
        if let id = id {
            delegate?.didPressCancel(id: id)
        }
    }
}
