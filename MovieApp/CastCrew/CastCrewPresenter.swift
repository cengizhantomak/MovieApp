//
//  CastCrewPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 30.06.2023.
//

import Foundation

protocol CastCrewPresentationLogic: AnyObject {
    func presentCast(response: CastCrewModels.FetchCastCrew.Response)
}

final class CastCrewPresenter: CastCrewPresentationLogic {
    
    weak var viewController: CastCrewDisplayLogic?
    
    func presentCast(response: CastCrewModels.FetchCastCrew.Response) {
        let displayedCast = response.cast.map {
            CastCrewModels.FetchCastCrew.ViewModel.DisplayedCast(
                name: $0.name,
                character: $0.character,
                profilePhotoPath: $0.profilePhotoPath
            )
        }
        
        let viewModel = CastCrewModels.FetchCastCrew.ViewModel(displayedCast: displayedCast)
        viewController?.displayGetCast(viewModel: viewModel)
    }
}
