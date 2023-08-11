//
//  LinkedInViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 29.07.2023.
//

import UIKit
import WebKit

protocol LinkedInDisplayLogic: AnyObject {
    func displayLinkedInProfile(viewModel: LinkedInModels.FetchLinkedIn.ViewModel)
}

final class LinkedInViewController: UIViewController {
    
    var interactor: LinkedInBusinessLogic?
    var router: (LinkedInRoutingLogic & LinkedInDataPassing)?
    
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
        interactor?.fetchLinkedInProfile()
        setupToolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isToolbarHidden = false
    }
    
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = LinkedInInteractor()
        let presenter = LinkedInPresenter()
        let router = LinkedInRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func setupToolBar() {
        let refreshBarButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let backBarButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: webView, action: #selector(webView.goBack))
        let forwardBarButton = UIBarButtonItem(image: UIImage(systemName: "arrow.forward"), style: .done, target: webView, action: #selector(webView.goForward))
        toolbarItems = [refreshBarButton, UIBarButtonItem.flexibleSpace(), backBarButton, UIBarButtonItem.fixedSpace(25), forwardBarButton]
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            webView.isLoading ? indicatorView.startAnimating() : indicatorView.stopAnimating()
        }
    }
}

// MARK: - DisplayLogic
extension LinkedInViewController: LinkedInDisplayLogic {
    func displayLinkedInProfile(viewModel: LinkedInModels.FetchLinkedIn.ViewModel) {
        let url = URL(string: viewModel.url)!
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), context: nil)
    }
}
