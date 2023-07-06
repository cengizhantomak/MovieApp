//
//  GetTicketViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import UIKit

protocol GetTicketDisplayLogic: AnyObject {
    
}

final class GetTicketViewController: UIViewController {
    
    // MARK: - VIP Properties
    
    var interactor: GetTicketBusinessLogic?
    var router: (GetTicketRoutingLogic & GetTicketDataPassing)?
    
    // MARK: - Outlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedSeats: Set<Int> = []
    
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
        
        navigationItem.title = "Get Ticket"
        setupCollectionView()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = GetTicketInteractor()
        let presenter = GetTicketPresenter()
        let router = GetTicketRouter()
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
        collectionView.register(.init(nibName: "SeatCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "SeatCollectionViewCell")
        collectionView.collectionViewLayout = getCompotionalLayout()
        collectionView.allowsMultipleSelection = true
    }
    
    // MARK: - CompotionalLayout
    
    func getCompotionalLayout() -> UICollectionViewLayout {
        
        // Item boyutunu tanımla
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / 9),
            heightDimension: .fractionalHeight(1.0)
        )
        
        // Itemi kullanarak bir grup oluştur
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing:5) // Sağdan ve soldan boşluk bırak
        
        // Grup boyutunu tanımla
        let groupLayout = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0 / 6)
        )
        
        // Grubu oluştur
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayout, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // Bölümü oluştur
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 35, bottom: 0, trailing: 35) // Bölümün içinden boşluk bırak
        
        // Layout'u oluştur ve döndür
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - DisplayLogic

extension GetTicketViewController: GetTicketDisplayLogic {
    
}

// MARK: - CollectionView

extension GetTicketViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 81
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeatCollectionViewCell", for: indexPath) as? SeatCollectionViewCell else { return UICollectionViewCell() }
        
        if selectedSeats.contains(indexPath.row) {
            cell.contentView.backgroundColor = UIColor(red: 0.28, green: 0.81, blue: 1, alpha: 1)
        } else {
            cell.contentView.backgroundColor = UIColor.white
        }
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SeatCollectionViewCell else { return }
        
        if selectedSeats.contains(indexPath.row) {
            selectedSeats.remove(indexPath.row)
            collectionView.deselectItem(at: indexPath, animated: true)
        } else {
            selectedSeats.insert(indexPath.row)
        }
        collectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectedSeats.remove(indexPath.row)
        collectionView.reloadItems(at: [indexPath])
    }
}
