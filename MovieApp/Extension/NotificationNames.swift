//
//  NotificationNames.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 7.07.2023.
//

import Foundation

extension Notification.Name {
    static let movieAddedToWatchlist = Notification.Name("movieAddedToWatchlist")
    static let movieDeletedToWatchlist = Notification.Name("movieDeletedToWatchlist")
    static let movieAddDeleteToWatchlistFailed = Notification.Name("movieAddDeleteToWatchlistFailed")
}
