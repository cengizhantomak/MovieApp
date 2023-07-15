//
//  NavigationCustomView.swift
//  MovieApp
//
//  Created by Kerem Tuna Tomak on 15.07.2023.
//

import UIKit

class NavigationCustomView: UIView {
    
    let title: UILabel
    let subTitle: UILabel
    let imageView: UIImageView

    override init(frame: CGRect) {
        title = UILabel(frame: CGRect(x: 40, y: 0, width: 210, height: 18))
        subTitle = UILabel(frame: CGRect(x: 40, y: 20, width: 210, height: 18))
        imageView = UIImageView(frame: CGRect(x: 0, y: 3, width: 32, height: 32))
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(viewModel: ChooseSeatModels.FetchChooseSeat.ViewModel) {
        
        addSubview(title)
        addSubview(subTitle)
        addSubview(imageView)
        
        title.text = viewModel.selectedMovieTitle
        title.font = UIFont(name: "SFProText-Semibold", size: 16)
        title.textColor = UIColor(named: "0F1B2B")
        
        subTitle.text = viewModel.selectedDate
        subTitle.font = UIFont(name: "SFProText-Medium", size: 12)
        subTitle.textColor = .systemGray
        
        if let profileUrl = ImageUrlHelper.imageUrl(for: viewModel.selectedMovieImage ?? "") {
            imageView.load(url: profileUrl)
        }
    }
}
