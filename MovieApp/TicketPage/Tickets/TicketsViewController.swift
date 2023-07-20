//
//  TicketsViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 18.07.2023.
//

import UIKit

protocol TicketsDisplayLogic: AnyObject {
    func displayTickets(viewModel: TicketsModels.FetchTickets.ViewModel)
    func displayDeleteTicketResult(viewModel: TicketsModels.DeleteTicket.ViewModel)
}

final class TicketsViewController: UIViewController {
    
    var interactor: TicketsBusinessLogic?
    var router: (TicketsRoutingLogic & TicketsDataPassing)?
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var displayedTickets = [TicketsModels.FetchTickets.ViewModel.DisplayedTicket]()
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor?.fetchTickets(request: TicketsModels.FetchTickets.Request())
        setupCollectionView()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = TicketsInteractor()
        let presenter = TicketsPresenter()
        let router = TicketsRouter()
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
        collectionView.register(.init(nibName: "TicketsCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "TicketsCollectionViewCell")
        collectionView.collectionViewLayout = getCompositionalLayout()
    }
    
    // MARK: - CompositionalLayout
    
    func getCompositionalLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 25, leading: 0, bottom: 25, trailing:0)
        
        let groupLayout = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0 / 1.2)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayout, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - DisplayLogic

extension TicketsViewController: TicketsDisplayLogic {
    func displayTickets(viewModel: TicketsModels.FetchTickets.ViewModel) {
        displayedTickets = viewModel.displayedTickets
        self.collectionView.reloadData()
    }
    
    func displayDeleteTicketResult(viewModel: TicketsModels.DeleteTicket.ViewModel) {
        if viewModel.success {
            interactor?.fetchTickets(request: TicketsModels.FetchTickets.Request())
        } else {
            UIAlertHelper.shared.showAlert(title: "Error", message: "Failed to delete ticket", buttonTitle: "OK", on: self)
        }
    }
}

// MARK: - CollectionView

extension TicketsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedTickets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicketsCollectionViewCell", for: indexPath) as? TicketsCollectionViewCell else { return UICollectionViewCell() }
        
        let model = displayedTickets[indexPath.item]
        cell.setCell(viewModel: model)
        
        cell.delegate = self
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        router?.routeToMap()
//    }
}

// MARK: - TicketsCollectionViewCellDelegate

extension TicketsViewController: TicketsCollectionViewCellDelegate {
    func didPressCancel(id: UUID) {
        let alertController = UIAlertController(title: "Confirmation", message: "Are you sure you want to cancel this ticket?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            self?.interactor?.deleteTicket(request: .init(ticketId: id))
        }
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }
}
