//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 26.06.2023.
//

import UIKit

protocol MoviesDisplayLogic: AnyObject {
    func displayFetchedMovies(viewModel: MoviesModels.FetchMovies.ViewModel)
}

final class MoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: MoviesBusinessLogic?
    var router: (MoviesRoutingLogic & MoviesDataPassing)?
    var displayedMovies: [MoviesModels.FetchMovies.ViewModel.DisplayedMovie] = []
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Movie"
        interactor?.fetchNowPlaying()
        setupTableView()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = MoviesInteractor()
        let presenter = MoviesPresenter()
        let router = MoviesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MoviesViewController: MoviesDisplayLogic {
    func displayFetchedMovies(viewModel: MoviesModels.FetchMovies.ViewModel) {
        displayedMovies = viewModel.displayedMovies
        tableView.reloadData()
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = displayedMovies[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovieId = displayedMovies[indexPath.row].id
        router?.routeToMovieDetails(with: selectedMovieId)
    }
}
