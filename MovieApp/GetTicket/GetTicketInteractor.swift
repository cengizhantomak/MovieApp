//
//  GetTicketInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import Foundation

protocol GetTicketBusinessLogic: AnyObject {
    
}

protocol GetTicketDataStore: AnyObject {
    
}

final class GetTicketInteractor: GetTicketBusinessLogic, GetTicketDataStore {
    
    var presenter: GetTicketPresentationLogic?
    var worker: GetTicketWorkingLogic = GetTicketWorker()
    
}
