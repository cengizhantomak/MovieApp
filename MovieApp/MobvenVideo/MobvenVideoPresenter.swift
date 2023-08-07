//
//  MobvenVideoPresenter.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.08.2023.
//

import Foundation

protocol MobvenVideoPresentationLogic: AnyObject {
    func presentVideoState(response: MobvenVideoModels.PlayVideo.Response)
}

final class MobvenVideoPresenter: MobvenVideoPresentationLogic {
    
    weak var viewController: MobvenVideoDisplayLogic?
    
    func presentVideoState(response: MobvenVideoModels.PlayVideo.Response) {
        let viewModel = MobvenVideoModels.PlayVideo.ViewModel(buttonTitle: response.isPlaying ? "pause.fill" : "play.fill")
        viewController?.displayVideoState(viewModel: viewModel)
    }
}
