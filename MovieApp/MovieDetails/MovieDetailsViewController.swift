//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import UIKit

protocol MovieDetailsDisplayLogic: AnyObject {
    func displayFetchedNames(viewModel: MovieDetailsModels.FetchNames.ViewModel)
    func displayFetchedDetails(viewModel: MovieDetailsModels.FetchNames.ViewModel2.DisplayedDetails)
    func displayFetchedImages(viewModel: MovieDetailsModels.FetchNames.ViewModel3)
}

final class MovieDetailsViewController: UIViewController {
    
    // MARK: - VIP Properties
    
    var interactor: MovieDetailsBusinessLogic?
    var router: (MovieDetailsRoutingLogic & MovieDetailsDataPassing)?
    
    // MARK: - Outlets
    
    @IBOutlet weak var detailsTableView: UITableView!
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
    
    // MARK: - Properties
    
    var displayedNames: [MovieDetailsModels.FetchNames.ViewModel.DisplayedCast] = []
    var displayedDetails: MovieDetailsModels.FetchNames.ViewModel2.DisplayedDetails?
    var displayedImages: [MovieDetailsModels.FetchNames.ViewModel3.DisplayedImages] = []
    
    enum Section: Int, CaseIterable {
        case Synopsis
        case Cast
        case Photos
        
        var title: String {
            switch self {
            case .Synopsis:
                return "Synopsis"
            case .Cast:
                return "Cast & Crew"
            case .Photos:
                return "Photos"
            }
        }
    }
    
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
        interactor?.fetchMovieNames()
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
    
    private func setupTableCollectionView() {
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.tableHeaderView = headerView
        detailsTableView.tableFooterView = footerView
        detailsTableView.register(UINib(nibName: "MovieDetailsTableViewCell", bundle: .main), forCellReuseIdentifier: "MovieDetailsTableViewCell")
        detailsTableView.register(UINib(nibName: "SynopsisTableViewCell", bundle: .main), forCellReuseIdentifier: "SynopsisTableViewCell")
        detailsTableView.register(SectionHeader.self, forHeaderFooterViewReuseIdentifier: "SectionHeader")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(.init(nibName: "CollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CollectionViewCell")
    }
}

extension MovieDetailsViewController: MovieDetailsDisplayLogic {
    func displayFetchedNames(viewModel: MovieDetailsModels.FetchNames.ViewModel) {
        displayedNames = viewModel.displayedCast
        detailsTableView.reloadData()
    }
    
    func displayFetchedDetails(viewModel: MovieDetailsModels.FetchNames.ViewModel2.DisplayedDetails) {
        displayedDetails = viewModel
        
        titleLabel.text = viewModel.title
        
        let totalMinutes = viewModel.runtime
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        let formattedString = "\(hours)hr \(minutes)m"
        durationLabel.text = formattedString
        
        genreLabel.text = viewModel.genres
        
        let vote = viewModel.vote / 2
        let formattedVote = String(format: "%.1f", vote) + "/5"
        ratingLabel.text = formattedVote
        
        let fullStars = Int(vote)
        let halfStar = vote - Float(fullStars)
        var starImages: [UIImage] = []
        let fullStarImage = UIImage(systemName: "star.fill")
        let halfStarImage = UIImage(systemName: "star.leadinghalf.filled")
        let emptyStarImage = UIImage(systemName: "star")
        for i in 0..<5 {
            if i < fullStars {
                starImages.append(fullStarImage!)
            } else if i == fullStars && halfStar >= 0.5 {
                starImages.append(halfStarImage!)
            } else {
                starImages.append(emptyStarImage!)
            }
        }
        
        starRatingStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for image in starImages {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            starRatingStackView.addArrangedSubview(imageView)
        }
        
        if let posterUrl = ImageUrlHelper.imageUrl(for: viewModel.posterPath) {
            posterImageView.load(url: posterUrl)
            backgroundImageView.load(url: posterUrl)
            //            backgroundImageView.addBlurEffect()
            //            if let blurredImage = backgroundImageView.image?.blurred(radius: 10.0) {
            //                backgroundImageView.image = blurredImage
            //            }
        }
        detailsTableView.reloadData()
    }
    
    func displayFetchedImages(viewModel: MovieDetailsModels.FetchNames.ViewModel3) {
        displayedImages = viewModel.displayedImages
        collectionView.reloadData()
    }
}

// MARK: - UITableView

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        
        switch section {
        case .Synopsis:
            return displayedDetails != nil ? 1 : 0
        case .Cast:
            return min(displayedNames.count, 4)
        case .Photos:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .Synopsis:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SynopsisTableViewCell", for: indexPath) as? SynopsisTableViewCell
            cell?.setCell(viewModel: displayedDetails?.overview ?? "")
            return cell ?? UITableViewCell()
        case .Cast:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsTableViewCell", for: indexPath) as? MovieDetailsTableViewCell
            let model = displayedNames[indexPath.row]
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
//        guard let section = Section(rawValue: section) else { return UIView() }
//
//        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeader") as? SectionHeader
//        sectionHeader?.title.text = section.title
//        sectionHeader?.button.isHidden = section == .Synopsis
//        sectionHeader?.button.addTarget(self, action: #selector(selectButton), for: .touchUpInside)
//        return sectionHeader
        
        guard let section = Section(rawValue: section) else { return UIView() }
        switch section {
        case .Synopsis:
            let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeader") as? SectionHeader
            sectionHeader?.title.text = section.title
            sectionHeader?.button.isHidden = true
            return sectionHeader
        case .Cast:
            let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeader") as? SectionHeader
            sectionHeader?.title.text = section.title
            sectionHeader?.button.isHidden = false
            sectionHeader?.button.addTarget(self, action: #selector(selectButtonCast), for: .touchUpInside)
            return sectionHeader
        case .Photos:
            let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeader") as? SectionHeader
            sectionHeader?.title.text = section.title
            sectionHeader?.button.isHidden = false
            sectionHeader?.button.addTarget(self, action: #selector(selectButtonPhotos), for: .touchUpInside)
            return sectionHeader
        }
    }
    
    @objc func selectButtonCast() {
        guard let router = router else { return }
        router.routeToCastCrew()
    }
    
    @objc func selectButtonPhotos() {
        print("tapped")
        guard let router = router else { return }
        router.routeToPhotos()
    }
}

// MARK: - CollectionView

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        let model = displayedImages[indexPath.item]
        cell.setCell(viewModel: model)
        return cell
    }
}

extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 50) / 3, height: (collectionView.frame.height))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(5)
    }
}
