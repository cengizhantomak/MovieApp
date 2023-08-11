//
//  LinkedInInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 29.07.2023.
//

import Foundation

protocol LinkedInBusinessLogic: AnyObject {
    func fetchLinkedInProfile()
}

protocol LinkedInDataStore: AnyObject {
    var profile: LinkedInModels.Profile? { get set }
}

final class LinkedInInteractor: LinkedInBusinessLogic, LinkedInDataStore {
    
    var presenter: LinkedInPresentationLogic?
    var worker: LinkedInWorkingLogic = LinkedInWorker()
    
    var profile: LinkedInModels.Profile?
    
    func fetchLinkedInProfile() {
        worker.fetchLinkedInProfile { profile in
            self.profile = profile
            let response = LinkedInModels.FetchLinkedIn.Response(profile: profile)
            presenter?.presentLinkedInProfile(response: response)
        }
    }
}
