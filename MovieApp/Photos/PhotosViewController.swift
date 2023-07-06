//
//  PhotosViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 5.07.2023.
//

import UIKit

protocol PhotosDisplayLogic: AnyObject {
    func displayGetPhotos(viewModel: PhotosModels.FethcPhotos.ViewModel)
}

final class PhotosViewController: UIViewController {
    
    var interactor: PhotosBusinessLogic?
    var router: (PhotosRoutingLogic & PhotosDataPassing)?
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var displayedPhotos: [PhotosModels.FethcPhotos.ViewModel.DisplayedImages] = []
    
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
        
        navigationItem.title = "Photos"
        interactor?.getPhotos()
        setupCollectionView()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = PhotosInteractor()
        let presenter = PhotosPresenter()
        let router = PhotosRouter()
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
        collectionView.register(.init(nibName: "PhotosCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        collectionView.collectionViewLayout = getCompotionalLayout()
    }
    
    // MARK: - CompotionalLayout
    
    func getCompotionalLayout() -> UICollectionViewLayout {
        
        // Item boyutunu tanımla
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        // Itemi kullanarak bir grup oluştur
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing:0) // Sağdan ve soldan 20 birim boşluk bırak
        
        // Grup boyutunu tanımla
        let groupLayout = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0 / 3)
        )
        
        // Grubu oluştur
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayout, subitems: [item])
        
        // Bölümü oluştur
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10) // Bölümün içinden sağdan ve soldan 20 birim boşluk bırak
        
        // Layout'u oluştur ve döndür
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - DisplayLogic

extension PhotosViewController: PhotosDisplayLogic {
    func displayGetPhotos(viewModel: PhotosModels.FethcPhotos.ViewModel) {
        displayedPhotos = viewModel.displayedImages
        collectionView.reloadData()
    }
}

// MARK: - CollectionView

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        
        let model = displayedPhotos[indexPath.item]
        cell.setCell(viewModel: model)
        return cell
    }
}
