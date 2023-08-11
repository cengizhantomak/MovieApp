//
//  SignUpViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 30.07.2023.
//

import UIKit
import WebKit

protocol SignUpDisplayLogic: AnyObject {
    func displaySignUp(viewModel: SignUpModels.FetchSignUp.ViewModel)
}

final class SignUpViewController: UIViewController {
    
    var interactor: SignUpBusinessLogic?
    var router: (SignUpRoutingLogic & SignUpDataPassing)?
    
    // MARK: - Outlet
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
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
        let request = SignUpModels.FetchSignUp.Request()
        interactor?.fetchSignUp(request: request)
    }
    
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = SignUpInteractor()
        let presenter = SignUpPresenter()
        let router = SignUpRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            webView.isLoading ? indicatorView.startAnimating() : indicatorView.stopAnimating()
        }
    }
}

// MARK: - DisplayLogic
extension SignUpViewController: SignUpDisplayLogic {
    func displaySignUp(viewModel: SignUpModels.FetchSignUp.ViewModel) {
        let url = URL(string: viewModel.url)!
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), context: nil)
    }
}
