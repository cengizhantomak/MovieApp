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
    
    // MARK: - Outlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        showLoadingView()
        navigationItem.title = "Videos"
        interactor?.fetchmovieImages()
        setupCollectionView()
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
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(.init(nibName: Constants.CellIdentifiers.videosCell, bundle: .main), forCellWithReuseIdentifier: Constants.CellIdentifiers.videosCell)
        collectionView.collectionViewLayout = getCompositionalLayout()
    }
    
    // MARK: - CompositionalLayout
    
    func getCompositionalLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing:0)
        
        let groupLayout = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0 / 3)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayout, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - DisplayLogic

extension VideosViewController: VideosDisplayLogic {
    func displayedFetchedVideos(viewModel: VideosModels.FetchVideos.ViewModel) {
        DispatchQueue.main.async {
            self.displayedVideos = viewModel.displayedVideos
            self.collectionView.reloadData()
            
        }
    }
}

// MARK: - CollectionView

extension VideosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedVideos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.videosCell, for: indexPath) as? VideosCollectionViewCell else { return UICollectionViewCell() }
        
        let model = displayedVideos[indexPath.item].key
        cell.loadVideo(videoID: model)
        hideLoadingView()
        return cell
    }
}

