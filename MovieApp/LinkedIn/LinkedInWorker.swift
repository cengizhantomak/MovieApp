//
//  LinkedInWorker.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 29.07.2023.
//

import Foundation

protocol LinkedInWorkingLogic: AnyObject {
    func fetchLinkedInProfile(completion: (LinkedInModels.Profile) -> Void)
}

final class LinkedInWorker: LinkedInWorkingLogic {
    func fetchLinkedInProfile(completion: (LinkedInModels.Profile) -> Void) {
        completion(LinkedInModels.Profile(url: "https://www.linkedin.com/in/cengizhantomak/"))
    }
}
