//
//  VideosPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 21.07.2023.
//

import Foundation

protocol VideosPresentationLogic: AnyObject {
    func presentVideos(response: VideosModels.FetchVideos.Response)
}

final class VideosPresenter: VideosPresentationLogic {
    
    weak var viewController: VideosDisplayLogic?
    
    func presentVideos(response: VideosModels.FetchVideos.Response) {
        var displayedVideos: [VideosModels.FetchVideos.ViewModel.DisplayedVideos] = []
        response.videos.forEach {
            displayedVideos.append(VideosModels.FetchVideos.ViewModel.DisplayedVideos(
                name: $0.name,
                key: $0.key))
        }
        
        let viewModel = VideosModels.FetchVideos.ViewModel(displayedVideos: displayedVideos)
        viewController?.displayedFetchedVideos(viewModel: viewModel)
    }
}
