//
//  VideosViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 21.07.2023.
//

import UIKit

protocol VideosDisplayLogic: AnyObject {
    func displayedFetchedVideos(viewModel: VideosModels.FetchVideos.ViewModel)
}

final class VideosViewController: UIViewController {
    
    var interactor: VideosBusinessLogic?
    var router: (VideosRoutingLogic & VideosDataPassing)?
    
    // MARK: - Property
    
    var displayedVideos: [VideosModels.FetchVideos.ViewModel.DisplayedVideos] = []
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.fetchmovieImages()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = VideosInteractor()
        let presenter = VideosPresenter()
        let router = VideosRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension VideosViewController: VideosDisplayLogic {
    func displayedFetchedVideos(viewModel: VideosModels.FetchVideos.ViewModel) {
        displayedVideos = viewModel.displayedVideos
    }
}
