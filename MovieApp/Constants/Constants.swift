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
    
    public enum StoryboardIdentifier {
        static let tabBarController = "TabBarController"
        static let signUpViewController = "SignUpViewController"
        static let resetPasswordViewController = "ResetPasswordViewController"
        static let myBankCardsViewController = "MyBankCardsViewController"
        static let linkedInViewController = "LinkedInViewController"
        static let mobvenVideoViewController = "MobvenVideoViewController"
        static let loginViewController = "LoginViewController"
        static let addBankCardViewController = "AddBankCardViewController"
        static let movieDetailsViewController = "MovieDetailsViewController"
        static let castCrewViewController = "CastCrewViewController"
        static let photosViewController = "PhotosViewController"
        static let videosViewController = "VideosViewController"
        static let getTicketViewController = "GetTicketViewController"
        static let watchlistViewController = "WatchlistViewController"
        static let chooseSeatViewController = "ChooseSeatViewController"
        static let paymentViewController = "PaymentViewController"
        static let congratsViewController = "CongratsViewController"
    }
    
    public enum StoryboardName {
        static let main = "Main"
        static let signUp = "SignUp"
        static let resetPassword = "ResetPassword"
        static let myBankCards = "MyBankCards"
        static let linkedIn = "LinkedIn"
        static let mobvenVideo = "MobvenVideo"
        static let addBankCard = "AddBankCard"
        static let movieDetails = "MovieDetails"
        static let castCrew = "CastCrew"
        static let photos = "Photos"
        static let videos = "Videos"
        static let getTicket = "GetTicket"
        static let chooseSeat = "ChooseSeat"
        static let payment = "Payment"
        static let congrats = "Congrats"
    }
}
