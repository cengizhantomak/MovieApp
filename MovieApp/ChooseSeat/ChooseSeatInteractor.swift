//
//  ChooseSeatInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 14.07.2023.
//

import Foundation

protocol ChooseSeatBusinessLogic: AnyObject {
    func getMovie()
}

protocol ChooseSeatDataStore: AnyObject {
    var selectedMovieTitle: String? { get set }
    var selectedMovieImage: String? { get set }
    var selectedDate: String? { get set }
    var selectedTheater: String? { get set }
}

final class ChooseSeatInteractor: ChooseSeatBusinessLogic, ChooseSeatDataStore {
    
    var presenter: ChooseSeatPresentationLogic?
    var worker: ChooseSeatWorkingLogic = ChooseSeatWorker()
    
    var selectedMovieTitle: String?
    var selectedMovieImage: String?
    var selectedDate: String?
    var selectedTheater: String?
    
    func getMovie() {
        guard let selectedMovieTitle,
        let selectedMovieImage,
        let selectedDate,
        let selectedTheater else { return }
        presenter?.presentMovie(selectedMovieTitle, selectedMovieImage, selectedDate, selectedTheater)
    }
}
