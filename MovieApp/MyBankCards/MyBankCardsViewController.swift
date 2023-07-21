//
//  MyBankCardsViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 21.07.2023.
//

import UIKit

protocol MyBankCardsDisplayLogic: AnyObject {
    func displayBankCards(viewModel: MyBankCardsModels.FetchMyBankCards.ViewModel)
}

final class MyBankCardsViewController: UIViewController {
    
    var interactor: MyBankCardsBusinessLogic?
    var router: (MyBankCardsRoutingLogic & MyBankCardsDataPassing)?
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var displayedBankCards = [MyBankCardsModels.FetchMyBankCards.ViewModel.DisplayedBankCard]()
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBankCardButtonTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor?.fetchBankCards(request: MyBankCardsModels.FetchMyBankCards.Request())
        setupCollectionView()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = MyBankCardsInteractor()
        let presenter = MyBankCardsPresenter()
        let router = MyBankCardsRouter()
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
        collectionView.register(.init(nibName: "MyBankCardsCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "MyBankCardsCollectionViewCell")
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
    
    // MARK: - Actions
    
    @objc func addBankCardButtonTapped() {
        router?.routeToAddBankCard()
    }
}

// MARK: - DisplayLogic

extension MyBankCardsViewController: MyBankCardsDisplayLogic {
    func displayBankCards(viewModel: MyBankCardsModels.FetchMyBankCards.ViewModel) {
        displayedBankCards = viewModel.displayedBankCard
        self.collectionView.reloadData()
    }
}

// MARK: - CollectionView

extension MyBankCardsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedBankCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyBankCardsCollectionViewCell", for: indexPath) as? MyBankCardsCollectionViewCell else { return UICollectionViewCell() }
        
        let model = displayedBankCards[indexPath.item]
        cell.setCell(viewModel: model)
        
        return cell
    }
}
