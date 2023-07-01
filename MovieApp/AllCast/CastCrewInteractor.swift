//
//  CastCrewInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 30.06.2023.
//

import Foundation

protocol CastCrewBusinessLogic: AnyObject {
    
}

protocol CastCrewDataStore: AnyObject {
    
}

final class CastCrewInteractor: CastCrewBusinessLogic, CastCrewDataStore {
    
    var presenter: CastCrewPresentationLogic?
    var worker: CastCrewWorkingLogic = CastCrewWorker()
    
}
