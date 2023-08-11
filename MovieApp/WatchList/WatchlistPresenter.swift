//
//  WatchlistPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import Foundation

protocol WatchlistPresentationLogic: AnyObject {
    func presentWatchList(response: WatchlistModels.FetchWatchList.Response)
    func presentWatchListMovieDetail()
}

final class WatchlistPresenter: WatchlistPresentationLogic {
    
    weak var viewController: WatchlistDisplayLogic?
    
    func presentWatchList(response: WatchlistModels.FetchWatchList.Response) {
        var displayedWatchList: [WatchlistModels.FetchWatchList.ViewModel.DisplayedWatchList] = []
        
        response.watchList.forEach {
            displayedWatchList.append(WatchlistModels.FetchWatchList.ViewModel.DisplayedWatchList(
                title: $0.title,
                releaseDate: $0.releaseDate,
                posterPath: $0.posterPath,
                vote: $0.vote,
                id: $0.id))
        }
        
        let viewModel = WatchlistModels.FetchWatchList.ViewModel(displayedWatchList: displayedWatchList)
        self.viewController?.displayFetchedWatchList(viewModel: viewModel)
    }
    
    func presentWatchListMovieDetail() {
        viewController?.displayWatchListMovieDetails()
    }
}
