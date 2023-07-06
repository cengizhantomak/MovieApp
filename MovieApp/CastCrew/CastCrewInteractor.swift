//
//  CastCrewInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 30.06.2023.
//

import Foundation

protocol CastCrewBusinessLogic: AnyObject {
    func getCast()
}

protocol CastCrewDataStore: AnyObject {
    var allCast: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedCast] {get set}
}

final class CastCrewInteractor: CastCrewBusinessLogic, CastCrewDataStore {
    
    var presenter: CastCrewPresentationLogic?
    var worker: CastCrewWorkingLogic = CastCrewWorker()
    
    var allCast: [MovieDetailsModels.FetchMovieDetails.ViewModel.DisplayedCast] = []
    
    func getCast() {
        let response = CastCrewModels.FetchCastCrew.Response(cast: allCast)
        presenter?.presentCast(response: response)
    }
}
