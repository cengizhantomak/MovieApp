//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import UIKit

protocol MoviesDisplayLogic: AnyObject {
    func displayFetchedMovies(viewModel: MoviesModels.FetchMovies.ViewModel)
}

final class MoviesViewController: UIViewController {
    
    // MARK: - VIP Properties
    
    var interactor: MoviesBusinessLogic?
    var router: (MoviesRoutingLogic & MoviesDataPassing)?
    
    // MARK: - Outlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Property
    
    var displayedMovies: [MoviesModels.FetchMovies.ViewModel.DisplayedMovie] = []
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.title = "Movie"
        interactor?.fetchNowPlaying()
        setupCollectionView()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = MoviesInteractor()
        let presenter = MoviesPresenter()
        let router = MoviesRouter()
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
        collectionView.register(.init(nibName: "MovieCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        collectionView.register(CollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionReusableView")
//        collectionView.collectionViewLayout = getCompotionalLayout()
    }
    
    // fractional -> kendini contain eden- parent view a oranı
    // estimated -> bir değer veriyoruz ama yapı kendisi oranını ayarlıyor
    // absolute -> sabit değer
    
//    private func getCompotionalLayout() -> UICollectionViewLayout {
//
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(0.5),
//            heightDimension: .fractionalHeight(1.0)
//        )
//
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        let groupLayout = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .fractionalHeight(0.5)
//        )
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayout, subitems: [item])
//        let section = NSCollectionLayoutSection(group: group)
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        return layout
//    }
}

extension MoviesViewController: MoviesDisplayLogic {
    func displayFetchedMovies(viewModel: MoviesModels.FetchMovies.ViewModel) {
        displayedMovies = viewModel.displayedMovies
        collectionView.reloadData()
    }
}

// MARK: - CollecionView

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        let model = displayedMovies[indexPath.item]
        cell.setCell(viewModel: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovieId = displayedMovies[indexPath.item].id
        router?.routeToMovieDetails(with: selectedMovieId)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionReusableView", for: indexPath) as? CollectionReusableView else { return UICollectionReusableView() }
        
        return headerView
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 40) / 2, height: (collectionView.frame.height + 9) / 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 54)
    }
}
