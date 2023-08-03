//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import UIKit
import CustomButton

protocol MovieDetailsDisplayLogic: AnyObject {
    func displayFetchedDetails(viewModel: MovieDetailsModels.FetchMovieDetails.ViewModel)
    func displayCast()
    func displayPhotos()
    func displayGetTicket()
}

final class MovieDetailsViewController: UIViewController {
    
    // MARK: - VIP Properties
    
    var interactor: MovieDetailsBusinessLogic?
    var router: (MovieDetailsRoutingLogic & MovieDetailsDataPassing)?
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var starRatingStackView: UIStackView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var getTicketButton: RedButton!
    @IBOutlet weak var addRemoveWatchlistButton: RedButton!
    
    // MARK: - Properties
    
    var displayedDetails: MovieDetailsModels.FetchMovieDetails.ViewModel?
    
    // MARK: -  Object lifecycle
    
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
        
        setupTableCollectionView()
        interactor?.fetchMovieDetails()
        setupButtonUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onMovieAddedToWatchlist(_:)), name: .movieAddedToWatchlist, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onMovieDeletedToWatchlist(_:)), name: .movieDeletedToWatchlist, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onMovieAddToWatchlistFailed(_:)), name: .movieAddDeleteToWatchlistFailed, object: nil)
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = MovieDetailsInteractor()
        let presenter = MovieDetailsPresenter()
        let router = MovieDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupButtonUI() {
        getTicketButton.setupButtonText(text: "Get Ticket")
        addRemoveWatchlistButton.setupButtonText(text: "Add Watchlist")
    }
    
    private func setupTableCollectionView() {
        
        // TableView'in üst kısmına boşluk ekleyin
        tableView.contentInsetAdjustmentBehavior = .never
        
        // Yerleşim alanınızın üstündeki statüs çubuğunu dikkate alın
        if #available(iOS 11.0, *) {
            tableView.contentInset = UIEdgeInsets(top: view.safeAreaInsets.top, left: 0, bottom: 0, right: 0)
        } else {
            tableView.contentInset = UIEdgeInsets(top: topLayoutGuide.length, left: 0, bottom: 0, right: 0)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.register(UINib(nibName: Constants.CellIdentifiers.castCell, bundle: .main), forCellReuseIdentifier: Constants.CellIdentifiers.castCell)
        tableView.register(UINib(nibName: Constants.CellIdentifiers.synopsisCell, bundle: .main), forCellReuseIdentifier: Constants.CellIdentifiers.synopsisCell)
        tableView.register(SectionHeader.self, forHeaderFooterViewReuseIdentifier: Constants.SectionHeader.movieDetailsSectionHeader)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(.init(nibName: Constants.CellIdentifiers.photosSectionCell, bundle: .main), forCellWithReuseIdentifier: Constants.CellIdentifiers.photosSectionCell)
    }
    
//    private func updateWatchlistButtonTitle() {
//        guard let displayedDetails else { return }
//
//        if displayedDetails.displayedWatchList.contains(where: { $0.watchListId == displayedDetails.id }) {
//            addRemoveWatchlistButton.setTitle("Remove Watchlist", for: .normal)
//        } else {
//            addRemoveWatchlistButton.setTitle("Add Watchlist", for: .normal)
//        }
//    }
    
    // MARK: - Action
    
    @IBAction func getTicketButtonTapped(_ sender: Any) {
        guard let displayedDetails else { return }
        interactor?.selectedMovieGetTicket(movie: displayedDetails.title, image: displayedDetails.posterPhotoPath)
    }
    
    @IBAction func addRemoveWatchlistButtonTapped(_ sender: Any) {
        guard var displayedDetails else { return }
        self.displayedDetails = interactor?.toggleWatchlistStatus(displayedDetails)
    }
    
    @objc func viewAllCastButton() {
        guard let displayedDetails else { return }
        interactor?.viewAllCast(with: displayedDetails.displayedCast)
    }
    
    @objc func viewAllPhotosButton() {
        guard let displayedDetails else { return }
        interactor?.viewAllPhotos(with: displayedDetails.displayedImages)
    }
    
    @IBAction func videosButtonTapped(_ sender: Any) {
        router?.routeToVideos()
    }
    
    @objc func onMovieAddedToWatchlist(_ notification: Notification) {
        DispatchQueue.main.async {
            self.addRemoveWatchlistButton.setTitle("Remove Watchlist", for: .normal)
            self.addRemoveWatchlistButton.backgroundColor = UIColor(named: "47CFFF")
            UIAlertHelper.shared.showAlert(
                title: "Added",
                message: "The movie has been successfully added to your watchlist.",
                buttonTitle: "OK",
                on: self
            )
        }
    }
    
    @objc func onMovieDeletedToWatchlist(_ notification: Notification) {
        DispatchQueue.main.async {
            self.addRemoveWatchlistButton.setTitle("Add Watchlist", for: .normal)
            self.addRemoveWatchlistButton.backgroundColor = UIColor(named: "buttonRed")
            UIAlertHelper.shared.showAlert(
                title: "Removed",
                message: "The movie has been successfully removed from your watch list.",
                buttonTitle: "OK",
                on: self
            )
        }
    }
    
    @objc func onMovieAddToWatchlistFailed(_ notification: Notification) {
        DispatchQueue.main.async {
            UIAlertHelper.shared.showAlert(
                title: "Error",
                message: "An error occurred while adding the movie to your watchlist.",
                buttonTitle: "OK",
                on: self
            )
        }
    }
}

// MARK: - DisplayLogic

extension MovieDetailsViewController: MovieDetailsDisplayLogic {
    func displayFetchedDetails(viewModel: MovieDetailsModels.FetchMovieDetails.ViewModel) {
        displayedDetails = viewModel
        guard let displayedDetails else { return }
        
        navigationItem.title = displayedDetails.title
        
        titleLabel.text = displayedDetails.title
        
        durationLabel.text = interactor?.formatRuntime(displayedDetails.runtime)
        
        genreLabel.text = displayedDetails.genres
        
        let vote = displayedDetails.vote / 2
        let formattedVote = String(format: "%.1f", vote) + "/5"
        ratingLabel.text = formattedVote
        
        if let starImages = StarRatingHelper.createStarImages(for: vote) {
            StarRatingHelper.updateStarRatingStackView(
                with: starImages,
                starSize: 20,
                starSpacing: 4,
                in: starRatingStackView
            )
        }
        
        if let posterUrl = ImageUrlHelper.imageUrl(for: displayedDetails.posterPhotoPath) {
            posterImageView.load(url: posterUrl)
            backgroundImageView.load(url: posterUrl)
//            backgroundImageView.addBlurEffect()
//            if let blurredImage = backgroundImageView.image?.blurred(radius: 10.0) {
//                backgroundImageView.image = blurredImage
//            }
        }
                
        tableView.reloadData()
        collectionView.reloadData()
        
        if displayedDetails.displayedWatchList.contains(where: { $0.watchListId == displayedDetails.id }) {
            addRemoveWatchlistButton.setTitle("Remove Watchlist", for: .normal)
            self.addRemoveWatchlistButton.backgroundColor = UIColor(named: "47CFFF")
        } else {
            addRemoveWatchlistButton.setTitle("Add Watchlist", for: .normal)
        }
    }
    
    func displayCast() {
        router?.routeToCastCrew()
    }
    
    func displayPhotos() {
        router?.routeToPhotos()
    }
    
    func displayGetTicket() {
        router?.routeToGetTicket()
    }
}

// MARK: - TableView

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MovieDetailsModels.Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = MovieDetailsModels.Section(rawValue: section) else { return 0 }
        
        switch section {
        case .Synopsis:
            return displayedDetails != nil ? 1 : 0
        case .Cast:
            return min(displayedDetails?.displayedCast.count ?? .zero, 4)
        case .Photos:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = MovieDetailsModels.Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .Synopsis:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.synopsisCell, for: indexPath) as? SynopsisTableViewCell
            cell?.setCell(viewModel: displayedDetails?.overview ?? "")
            return cell ?? UITableViewCell()
        case .Cast:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.castCell, for: indexPath) as? CastTableViewCell
            guard let model = displayedDetails?.displayedCast[indexPath.row] else { return UITableViewCell() }
            cell?.setCell(viewModel: model)
            return cell ?? UITableViewCell()
        case .Photos:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = MovieDetailsModels.Section(rawValue: section) else { return UIView() }

        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.SectionHeader.movieDetailsSectionHeader) as? SectionHeader
        sectionHeader?.title.text = section.title

        switch section {
        case .Synopsis:
            sectionHeader?.button.isHidden = true
        case .Cast, .Photos:
            sectionHeader?.button.isHidden = false
            if section == .Cast {
                sectionHeader?.button.addTarget(self, action: #selector(viewAllCastButton), for: .touchUpInside)
            } else if section == .Photos {
                sectionHeader?.button.addTarget(self, action: #selector(viewAllPhotosButton), for: .touchUpInside)
            }
        }

        return sectionHeader
    }
}

// MARK: - CollectionView

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedDetails?.displayedImages.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.photosSectionCell, for: indexPath) as? PhotosSectionCollectionViewCell else { return UICollectionViewCell() }
        
        guard let model = displayedDetails?.displayedImages[indexPath.item] else { return cell }
        cell.setCell(viewModel: model)
        return cell
    }
}

// MARK: - CollectionViewDelegateFlowLayout

extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 50) / 3, height: (collectionView.frame.height))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(5)
    }
}
