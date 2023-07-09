//
//  WatchlistInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import Foundation

protocol WatchlistBusinessLogic: AnyObject {
    func fetchWatchList()
    func selectWatchListMovieDetail(index: Int)
}

protocol WatchlistDataStore: AnyObject {
    var selectedMovieId: Int? { get set }
    var watchListResponse: [MoviesResponse.Movie] { get set }
}

final class WatchlistInteractor: WatchlistBusinessLogic, WatchlistDataStore {
    
    var presenter: WatchlistPresentationLogic?
    var worker: WatchlistWorkingLogic = WatchlistWorker()
    
    var selectedMovieId: Int?
    var watchListResponse: [MoviesResponse.Movie] = []
    
    func fetchWatchList() {
        worker.getWatchList { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                self.watchListResponse = response.results
                let response = WatchlistModels.FetchWatchList.Response(watchList: response.results)
                self.presenter?.presentWatchList(response: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func selectWatchListMovieDetail(index: Int) {
        selectedMovieId = watchListResponse[index].id
        presenter?.presentWatchListMovieDetail()
    }
}
