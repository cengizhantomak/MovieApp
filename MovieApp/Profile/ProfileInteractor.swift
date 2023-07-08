//
//  ProfileInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 8.07.2023.
//

import Foundation

protocol ProfileBusinessLogic: AnyObject {
    func fetchProfile()
}

protocol ProfileDataStore: AnyObject {
    
}

final class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    
    var presenter: ProfilePresentationLogic?
    var worker: ProfileWorkingLogic = ProfileWorker()
    
    func fetchProfile() {
        worker.getProfile { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let profile):
                let response = ProfileModels.FetchProfile.Response(profile: profile)
                self.presenter?.presentProfile(response: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
