//
//  VideosInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 21.07.2023.
//

import Foundation

protocol VideosBusinessLogic: AnyObject {
    func fetchmovieImages()
}

protocol VideosDataStore: AnyObject {
    var selectedMovieID: Int? { get set }
}

final class VideosInteractor: VideosBusinessLogic, VideosDataStore {
    
    var presenter: VideosPresentationLogic?
    var worker: VideosWorkingLogic = VideosWorker()
    
    var selectedMovieID: Int?
    
    func fetchmovieImages() {
        guard let id = selectedMovieID else { return }
        worker.getMovieVideos(id: id) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let videos):
                let response = VideosModels.FetchVideos.Response(videos: videos.results)
                self.presenter?.presentVideos(response: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
