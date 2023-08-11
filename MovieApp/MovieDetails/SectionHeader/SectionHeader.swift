//
//  SectionHeader.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 29.06.2023.
//

import UIKit

class SectionHeader: UITableViewHeaderFooterView {

    var title = UILabel()
    var button = UIButton()
    
    override init(reuseIdentifier: String?) {
        super .init(reuseIdentifier: reuseIdentifier)
        configureSectionHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSectionHeader() {
        title.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(title)
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 54),
            button.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        title.font = UIFont(name: "SFProText-Medium", size: 18)
        title.textColor = UIColor(named: "0F1B2B")
        
        button.setTitle("View All", for: .normal)
        button.setTitleColor(UIColor(named: "47CFFF"), for: .normal)
        let customFont = UIFont(name: "SFProText-Medium", size: 14)
        button.titleLabel?.font = customFont
    }
}
