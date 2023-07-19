//
//  WatchlistViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import UIKit

protocol WatchlistDisplayLogic: AnyObject {
    func displayFetchedWatchList(viewModel: WatchlistModels.FetchWatchList.ViewModel)
    func displayWatchListMovieDetails()
}

final class WatchlistViewController: UIViewController {
    
    // MARK: - VIP Properties
    
    var interactor: WatchlistBusinessLogic?
    var router: (WatchlistRoutingLogic & WatchlistDataPassing)?
    
    // MARK: - Outlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Property
    
    var displayedWatchList: [WatchlistModels.FetchWatchList.ViewModel.DisplayedWatchList] = []
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor?.fetchWatchList()
        setupCollectionView()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = WatchlistInteractor()
        let presenter = WatchlistPresenter()
        let router = WatchlistRouter()
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
        collectionView.register(.init(nibName: "WatchListCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "WatchListCollectionViewCell")
    }
}

// MARK: - DisplayLogic

extension WatchlistViewController: WatchlistDisplayLogic {
    func displayFetchedWatchList(viewModel: WatchlistModels.FetchWatchList.ViewModel) {
        displayedWatchList = viewModel.displayedWatchList
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func displayWatchListMovieDetails() {
        router?.routeToMovieDetails()
    }
}

// MARK: - CollecionView

extension WatchlistViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedWatchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchListCollectionViewCell", for: indexPath) as? WatchListCollectionViewCell else { return UICollectionViewCell() }
        
        let model = displayedWatchList[indexPath.item]
        cell.setCell(viewModel: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.selectWatchListMovieDetail(index: indexPath.item)
    }
}

// MARK: - CollectionViewDelegateFlowLayout

extension WatchlistViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 40) / 2, height: (collectionView.frame.height + 5) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(27)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
}
