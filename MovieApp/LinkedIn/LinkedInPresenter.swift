//
//  LinkedInPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 29.07.2023.
//

import Foundation

protocol LinkedInPresentationLogic: AnyObject {
    func presentLinkedInProfile(response: LinkedInModels.FetchLinkedIn.Response)
}

final class LinkedInPresenter: LinkedInPresentationLogic {
    
    weak var viewController: LinkedInDisplayLogic?
    
    func presentLinkedInProfile(response: LinkedInModels.FetchLinkedIn.Response) {
        let viewModel = LinkedInModels.FetchLinkedIn.ViewModel(url: response.profile.url)
        viewController?.displayLinkedInProfile(viewModel: viewModel)
    }
}
