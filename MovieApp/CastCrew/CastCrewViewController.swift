//
//  CastCrewViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 30.06.2023.
//

import UIKit

protocol CastCrewDisplayLogic: AnyObject {
    func displayGetCast(viewModel: CastCrewModels.FetchCastCrew.ViewModel)
}

final class CastCrewViewController: UIViewController {
    
    // MARK: - VIP Properties
    
    var interactor: CastCrewBusinessLogic?
    var router: (CastCrewRoutingLogic & CastCrewDataPassing)?
    
    // MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Property
    
    var displayedCast: [CastCrewModels.FetchCastCrew.ViewModel.DisplayedCast] = []
    
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
        interactor?.getCast()
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
        tableView.register(UINib(nibName: "CastCrewTableViewCell", bundle: .main), forCellReuseIdentifier: "CastCrewTableViewCell")
    }
}

extension CastCrewViewController: CastCrewDisplayLogic {
    func displayGetCast(viewModel: CastCrewModels.FetchCastCrew.ViewModel) {
        displayedCast = viewModel.displayedCast
        tableView.reloadData()
    }
}

// MARK: - UITableView

extension CastCrewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedCast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastCrewTableViewCell", for: indexPath) as? CastCrewTableViewCell
        else {
            return UITableViewCell()
        }
        let model = displayedCast[indexPath.row]
        cell.setCell(viewModel: model)
        return cell
    }
}
