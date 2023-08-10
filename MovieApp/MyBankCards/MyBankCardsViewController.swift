//
//  MyBankCardsViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 21.07.2023.
//

import UIKit

protocol selectionBankCardDelegate {
    func getBankCardData(nameCard: String?, cardNumber: String?, dateExpire: String?, cvv: String?)
}

protocol MyBankCardsDisplayLogic: AnyObject {
    func displayBankCards(viewModel: MyBankCardsModels.FetchMyBankCards.ViewModel)
    func displayDeleteBankCardResult(viewModel: MyBankCardsModels.DeleteBankCard.ViewModel)
//    func displaySelectBankCard()
    func displayOriginViewController(viewModel: String?)
}

final class MyBankCardsViewController: UIViewController {
    
    var interactor: MyBankCardsBusinessLogic?
    var router: (MyBankCardsRoutingLogic & MyBankCardsDataPassing)?
    var delegate: selectionBankCardDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var displayedBankCards: [MyBankCardsModels.FetchMyBankCards.ViewModel.DisplayedBankCard] = []
    var originViewController: String?
    
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
        
        navigationItem.title = "My Bank Cards"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBankCardButtonTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor?.fetchBankCards(request: MyBankCardsModels.FetchMyBankCards.Request())
        interactor?.getOriginViewController()
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
        collectionView.register(.init(nibName: Constants.CellIdentifiers.myBankCardsCell, bundle: .main), forCellWithReuseIdentifier: Constants.CellIdentifiers.myBankCardsCell)
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
        displayedBankCards = viewModel.displayedBankCard ?? []
        self.collectionView.reloadData()
    }
    
    func displayDeleteBankCardResult(viewModel: MyBankCardsModels.DeleteBankCard.ViewModel) {
        if viewModel.success {
            interactor?.fetchBankCards(request: MyBankCardsModels.FetchMyBankCards.Request())
        } else {
            UIAlertHelper.shared.showAlert(title: "Error", message: "Failed to delete Bank Card", buttonTitle: "OK", on: self)
        }
    }
    
//    func displaySelectBankCard() {
//        router?.routeToSelectBankCardPayment()
//    }
    
    func displayOriginViewController(viewModel: String?) {
        originViewController = viewModel
    }
}

// MARK: - CollectionView

extension MyBankCardsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedBankCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.myBankCardsCell, for: indexPath) as? MyBankCardsCollectionViewCell else { return UICollectionViewCell() }
        
        let model = displayedBankCards[indexPath.item]
        cell.setCell(viewModel: model)
        
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if originViewController == Constants.StoryboardIdentifier.paymentViewController {
            let selectedBankCard = displayedBankCards[indexPath.item]
            delegate?.getBankCardData(nameCard: selectedBankCard.cardHolder, cardNumber: selectedBankCard.cardNumber, dateExpire: selectedBankCard.cardExpires, cvv: selectedBankCard.cvv)
            router?.routeToSelectBankCardPayment()
        }
    }
}

// MARK: - TicketsCollectionViewCellDelegate

extension MyBankCardsViewController: MyBankCardsCollectionViewCellDelegate {
    func didPressCancel(id: UUID) {
        let alertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to cancel this Bank Card?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            self?.interactor?.deleteBankCard(request: .init(bankCardId: id))
        }
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }
}
