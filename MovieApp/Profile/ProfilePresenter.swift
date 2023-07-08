//
//  ProfilePresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 8.07.2023.
//

import Foundation

protocol ProfilePresentationLogic: AnyObject {
    func presentProfile(response: ProfileModels.FetchProfile.Response)
}

final class ProfilePresenter: ProfilePresentationLogic {
    
    weak var viewController: ProfileDisplayLogic?
    
    func presentProfile(response: ProfileModels.FetchProfile.Response) {
        let displayedProfile = ProfileModels.FetchProfile.ViewModel(
            id: response.profile.id,
            name: response.profile.name,
            username: response.profile.username,
            avatarPath: response.profile.avatar.tmdb.avatarPath
        )
        
        DispatchQueue.main.async {
            self.viewController?.displayProfile(viewModel: displayedProfile)
        }
    }
}
