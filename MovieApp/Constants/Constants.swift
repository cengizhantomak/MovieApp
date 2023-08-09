//
//  Constants.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 2.08.2023.
//

import Foundation

public enum Constants {
    public enum CellIdentifiers {
        static let movieCell = "MovieCollectionViewCell"
        static let castCell = "CastTableViewCell"
        static let synopsisCell = "SynopsisTableViewCell"
        static let photosSectionCell = "PhotosSectionCollectionViewCell"
        static let castCrewCell = "CastCrewTableViewCell"
        static let photosCell = "PhotosCollectionViewCell"
        static let videosCell = "VideosCollectionViewCell"
        static let watchListCell = "WatchListCollectionViewCell"
        static let seatCell = "SeatCollectionViewCell"
        static let myBankCardsCell = "MyBankCardsCollectionViewCell"
        static let ticketsCell = "TicketsCollectionViewCell"
    }
    public enum SectionHeader {
        static let movieSectionHeader = "MovieCollectionReusableView"
        static let movieDetailsSectionHeader = "SectionHeader"
    }
    public enum textFieldAccessibilityIdentifier {
        static let nameCardTextField = "nameCardTextField"
        static let cardNumberTextField = "cardNumberTextField"
        static let dateExpireTextField = "dateExpireTextField"
        static let cvvTextField = "cvvTextField"
    }
}
