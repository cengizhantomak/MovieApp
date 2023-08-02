//
//  Constants.swift
//  MovieApp
//
//  Created by Kerem Tuna Tomak on 2.08.2023.
//

import Foundation

public enum Constants {
    public enum CellIdentifiers {
        static let movieCell = "MovieCollectionViewCell"
        static let castCell = "CastTableViewCell"
        static let synopsisCell = "SynopsisTableViewCell"
        static let photosSectionCell = "PhotosSectionCollectionViewCell"
        static let seatCell = "SeatCollectionViewCell"
    }
    public enum ReuseIdentifiers {
        static let movieReusable = "MovieCollectionReusableView"
        static let sectionHeaderReusable = "SectionHeader"
    }
}
