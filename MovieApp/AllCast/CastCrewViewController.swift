//
//  CastCrewViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 30.06.2023.
//

import UIKit

protocol CastCrewDisplayLogic: AnyObject {
    func displayAllCast(viewModel: AllCastModels.FetchAllCast.ViewModel)
}

final class CastCrewViewController: UIViewController {
    
    // MARK: - VIP Properties
    
    var interactor: CastCrewBusinessLogic?
    var router: (CastCrewRoutingLogic & CastCrewDataPassing)?
    
    // MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Property
    
    var allCast: [MovieDetailsModels.FetchNames.ViewModel.DisplayedCast] = []
    
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
        navigationItem.title = "Cast & Crew"
        setupTableView()
    }
    
    // MARK: -  Setup
    
    private func setup() {
        let viewController = self
        let interactor = CastCrewInteractor()
        let presenter = CastCrewPresenter()
        let router = CastCrewRouter()
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
        tableView.register(UINib(nibName: "MovieDetailsTableViewCell", bundle: .main), forCellReuseIdentifier: "MovieDetailsTableViewCell")
    }
}

extension CastCrewViewController: CastCrewDisplayLogic {
    func displayAllCast(viewModel: AllCastModels.FetchAllCast.ViewModel) {
        tableView.reloadData()
    }
}

// MARK: - UITableView

extension CastCrewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsTableViewCell", for: indexPath) as? MovieDetailsTableViewCell
        else {
            return UITableViewCell()
        }
        let model = allCast[indexPath.row]
        cell.setCell(viewModel: model)
        return cell
    }
}
