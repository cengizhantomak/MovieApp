//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import UIKit

protocol MovieDetailsDisplayLogic: AnyObject {
    func displayFetchedNames(viewModel: MovieDetailsModels.FetchNames.ViewModel)
    func displayFetchedDetails(viewModel: MovieDetailsModels.FetchNames.ViewModel2)
}

final class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    
    var interactor: MovieDetailsBusinessLogic?
    var router: (MovieDetailsRoutingLogic & MovieDetailsDataPassing)?
    var displayedNames: [MovieDetailsModels.FetchNames.ViewModel.DisplayedCast] = []
    var displayedDetails: String?
    
    enum Section: Int, CaseIterable {
        case Synopsis
        case Cast
        
        var title: String {
            switch self {
            case .Synopsis:
                return "Synopsis"
            case .Cast:
                return "Cast & Crew"
            }
        }
    }
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    

    
    // MARK: Setup
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        interactor?.fetchMovieNames()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        interactor?.fetchMovieNames()
//    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.register(UINib(nibName: "MovieDetailsTableViewCell", bundle: .main), forCellReuseIdentifier: "MovieDetailsTableViewCell")
        tableView.register(UINib(nibName: "SynopsisTableViewCell", bundle: .main), forCellReuseIdentifier: "SynopsisTableViewCell")
        tableView.register(SectionHeader.self, forHeaderFooterViewReuseIdentifier: "SectionHeader")
    }
}


extension MovieDetailsViewController: MovieDetailsDisplayLogic {
    func displayFetchedDetails(viewModel: MovieDetailsModels.FetchNames.ViewModel2) {
        displayedDetails = viewModel.overview
        headerLabel.text = viewModel.title
        runtimeLabel.text = "\(viewModel.runtime) min."
        genresLabel.text = viewModel.genres
        voteLabel.text = "\(viewModel.vote)"
        tableView.reloadData()
    }
    
    func displayFetchedNames(viewModel: MovieDetailsModels.FetchNames.ViewModel) {
        displayedNames = viewModel.displayedCast
        tableView.reloadData()
    }
    
}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return min(displayedNames.count, 4)
        
        guard let section = Section(rawValue: section) else { return 1 }
        switch section {
        case .Synopsis:
            return min(displayedDetails?.count ?? 0, 1)
        case .Cast:
            return min(displayedNames.count, 4)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsTableViewCell", for: indexPath) as? MovieDetailsTableViewCell
//        else {
//            return UITableViewCell()
//        }
//        let model = displayedNames[indexPath.row]
//        cell.setCell(viewModel: model)
//        return cell
        
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .Synopsis:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SynopsisTableViewCell", for: indexPath) as? SynopsisTableViewCell
            cell?.setCell(viewModel: displayedDetails ?? "")
            return cell ?? UITableViewCell()
        case .Cast:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsTableViewCell", for: indexPath) as? MovieDetailsTableViewCell
            let model = displayedNames[indexPath.row]
            cell?.setCell(viewModel: model)
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
            sectionHeader?.button.setTitle("View All", for: .normal)
            sectionHeader?.button.setTitleColor(UIColor(cgColor: .init(red: 0.28, green: 0.81, blue: 1, alpha: 1)), for: .normal)
            let customFont = UIFont(name: "SFProText-Medium", size: 14) // Özel font adını ve boyutunu belirtin
            sectionHeader?.button.titleLabel?.font = customFont
            sectionHeader?.button.isHidden = false
            sectionHeader?.button.addTarget(self, action: #selector(selectButton), for: .touchUpInside)
            return sectionHeader
        }
    }
    
    @objc func selectButton() {
        print("tapped")
        let storyboard = UIStoryboard(name: "CastCrew", bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "CastCrewViewController") as? CastCrewViewController else { return }
        
        destinationVC.allCast = displayedNames
        destinationVC.loadViewIfNeeded()
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
