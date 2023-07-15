//
//  ChooseSeatViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 14.07.2023.
//

import UIKit

protocol ChooseSeatDisplayLogic: AnyObject {
    func displayFetchedMovie(viewModel: ChooseSeatModels.FetchChooseSeat.ViewModel)
    func updateViewComponents()
}

final class ChooseSeatViewController: UIViewController {
    
    var interactor: ChooseSeatBusinessLogic?
    var router: (ChooseSeatRoutingLogic & ChooseSeatDataPassing)?
    
    // MARK: - Outlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var seatLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    // MARK: - VIP Properties
    
    let row = ["A", "B", "C", "D", "E", "F", "G", "H", "I"]
    let seat = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    var selectedSeats = [String]()
    var displayedMovie: ChooseSeatModels.FetchChooseSeat.ViewModel?
    
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
        
        interactor?.getMovie()
        setupNavigationBar()
        setupCollectionView()
        continueButton.isEnabled = false
        continueButton.backgroundColor = .systemGray
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = ChooseSeatInteractor()
        let presenter = ChooseSeatPresenter()
        let router = ChooseSeatRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupNavigationBar() {
        guard let displayedMovie else { return }
        let customView = NavigationCustomView(frame: CGRect(x: 0, y: 0, width: 250, height: 38))
        customView.setupView(viewModel: displayedMovie)
        navigationItem.titleView = customView
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(.init(nibName: "SeatCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "SeatCollectionViewCell")
        collectionView.collectionViewLayout = getCompositionalLayout()
        collectionView.allowsMultipleSelection = true
    }
    
    // MARK: - CompositionalLayout
    
    func getCompositionalLayout() -> UICollectionViewLayout {
        
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / 3),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 3, bottom: 0, trailing:3)
        
        // Group in Group
        let innerGroupLayout = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / 3),
            heightDimension: .fractionalHeight(1.0)
        )
        let innerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: innerGroupLayout, subitems: [item])
        innerGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6)
        
        let middleGroupLayout = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0 / 3)
        )
        let middleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: middleGroupLayout, subitems: [innerGroup])
        middleGroup.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 0 , bottom: 3, trailing: 0)
        
        let outerGroupLayout = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.45)
        )
        let outerGroup = NSCollectionLayoutGroup.vertical(layoutSize: outerGroupLayout, subitems: [middleGroup])
        outerGroup.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 35 , bottom: 6, trailing: 35)
        
        // Section
        let section = NSCollectionLayoutSection(group: outerGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0 , bottom: 0, trailing: 0)
        
        // Layout
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
    }
}

// MARK: - DisplayLogic

extension ChooseSeatViewController: ChooseSeatDisplayLogic {
    func displayFetchedMovie(viewModel: ChooseSeatModels.FetchChooseSeat.ViewModel) {
        displayedMovie = viewModel
    }
    
    func updateViewComponents() {
        selectedSeats.sort()
        seatLabel.text = selectedSeats.joined(separator: ", ") + (selectedSeats.isEmpty ? "" : " SELECTED")
        let totalAmount = Double(selectedSeats.count) * 18.00
        priceLabel.text = "$ " + String(format: "%.2f", totalAmount)
        
        if selectedSeats.isEmpty {
            continueButton.isEnabled = false
            continueButton.backgroundColor = .systemGray
        } else {
            continueButton.isEnabled = true
            continueButton.backgroundColor = UIColor(red: 0.9, green: 0.1, blue: 0.22, alpha: 1)
        }
    }
}

// MARK: - UICollectionView

extension ChooseSeatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return row.count * seat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeatCollectionViewCell", for: indexPath) as? SeatCollectionViewCell else { return UICollectionViewCell() }
        
        var combined = [String]()
        
        row.forEach { letter in
            seat.forEach { number in
                combined.append("\(letter)\(number)")
            }
        }
        
        let value = combined[indexPath.row]
        cell.textLabel.text = value
        cell.isSelected = cell.isSelected
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedSeats.count >= 10 {
            collectionView.deselectItem(at: indexPath, animated: true)
            
            UIAlertHelper.shared.showAlert(
                title: "Seat Selection Limit Reached",
                message: "You can select up to 10 seats only.",
                buttonTitle: "OK",
                on: self
            )
        } else {
            guard let cell = collectionView.cellForItem(at: indexPath) as? SeatCollectionViewCell else { return }
            
            selectedSeats.append(cell.textLabel.text ?? "")
            updateViewComponents()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SeatCollectionViewCell else { return }
        
        if let index = selectedSeats.firstIndex(of: cell.textLabel.text ?? "") {
            selectedSeats.remove(at: index)
            updateViewComponents()
        }
    }
}
