//
//  CongratsViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 17.07.2023.
//

import UIKit

protocol CongratsDisplayLogic: AnyObject {
    func displayLatestTicket(viewModel: CongratsModels.FetchCongrats.ViewModel)
}

final class CongratsViewController: UIViewController {
    
    var interactor: CongratsBusinessLogic?
    var router: (CongratsRoutingLogic & CongratsDataPassing)?
    
    // MARK: - Outlet
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var theatreLabel: UILabel!
    @IBOutlet weak var seatLabel: UILabel!
    
    
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: false)
        interactor?.fetchLatestTicket()
    }
    
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = CongratsInteractor()
        let presenter = CongratsPresenter()
        let router = CongratsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Action
    @IBAction func exitButtonTapped(_ sender: Any) {
        router?.routeTo()
    }
}

// MARK: - DisplayLogic
extension CongratsViewController: CongratsDisplayLogic {
    func displayLatestTicket(viewModel: CongratsModels.FetchCongrats.ViewModel) {
        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
        theatreLabel.text = viewModel.theatre
        seatLabel.text = viewModel.seat
    }
}
