//
//  ProfileInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 8.07.2023.
//

import Foundation

protocol ProfileBusinessLogic: AnyObject {
    func fetchProfile()
    func performLogout(completion: @escaping (Result<Void, Error>) -> Void)
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
                presenter?.presentProfile(response: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func performLogout(completion: @escaping (Result<Void, Error>) -> Void) {
        worker.deleteAllData(entity: "MovieTicket") { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success:
                worker.deleteAllData(entity: "BankCard", completion: completion)
                clearUserDefaults()
                clearCache()
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func clearUserDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
    
    func clearCache() {
        URLCache.shared.removeAllCachedResponses()
    }
}
