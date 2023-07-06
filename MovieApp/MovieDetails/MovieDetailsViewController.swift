//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import UIKit

protocol MovieDetailsDisplayLogic: AnyObject {
    func displayFetchedDetails(viewModel: MovieDetailsModels.FetchMovieDetails.ViewModel)
    func displayCast()
    func displayPhotos()
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
    
    // MARK: - Properties
    
    var displayedDetails: MovieDetailsModels.FetchMovieDetails.ViewModel?
    
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
        interactor?.fetchMovieDetails()
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.register(UINib(nibName: "CastTableViewCell", bundle: .main), forCellReuseIdentifier: "CastTableViewCell")
        tableView.register(UINib(nibName: "SynopsisTableViewCell", bundle: .main), forCellReuseIdentifier: "SynopsisTableViewCell")
        tableView.register(SectionHeader.self, forHeaderFooterViewReuseIdentifier: "SectionHeader")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(.init(nibName: "PhotosSectionCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "PhotosSectionCollectionViewCell")
    }
    
    private func formatRuntime(_ totalMinutes: Int) -> String {
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return "\(hours)hr \(minutes)m"
    }
}

extension MovieDetailsViewController: MovieDetailsDisplayLogic {
    func displayFetchedDetails(viewModel: MovieDetailsModels.FetchMovieDetails.ViewModel) {
        displayedDetails = viewModel
        
        titleLabel.text = viewModel.title
        
        durationLabel.text = formatRuntime(viewModel.runtime)
        
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
        
        starImages.reserveCapacity(5)
        
        for i in 0..<5 {
                let starImage: UIImage
                
                if i < fullStars {
                    starImage = fullStarImage!
                } else if i == fullStars && halfStar >= 0.5 {
                    starImage = halfStarImage!
                } else {
                    starImage = emptyStarImage!
                }
            
                starImages.append(starImage)
            }
        
        starRatingStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for image in starImages {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            starRatingStackView.addArrangedSubview(imageView)
        }
        
        if let posterUrl = ImageUrlHelper.imageUrl(for: viewModel.posterPhotoPath) {
            posterImageView.load(url: posterUrl)
            backgroundImageView.load(url: posterUrl)
//            backgroundImageView.addBlurEffect()
//            if let blurredImage = backgroundImageView.image?.blurred(radius: 10.0) {
//                backgroundImageView.image = blurredImage
//            }
        }
        
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    func displayCast() {
        router?.routeToCastCrew()
    }
    
    func displayPhotos() {
        router?.routeToPhotos()
    }
}

// MARK: - TableView

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
            return min(displayedDetails?.displayedCast.count ?? .zero, 4)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as? CastTableViewCell
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
        guard let section = Section(rawValue: section) else { return UIView() }

        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeader") as? SectionHeader
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
    
    @objc func viewAllCastButton() {
        guard let displayedDetails else { return }
        interactor?.viewAllCast(with: displayedDetails.displayedCast)
    }
    
    @objc func viewAllPhotosButton() {
        guard let displayedDetails else { return }
        interactor?.viewAllPhotos(with: displayedDetails.displayedImages)
    }
}

// MARK: - CollectionView

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedDetails?.displayedImages.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosSectionCollectionViewCell", for: indexPath) as? PhotosSectionCollectionViewCell else { return UICollectionViewCell() }
        
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
