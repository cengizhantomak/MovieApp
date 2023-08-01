//
//  ProfileViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 8.07.2023.
//

import UIKit
import CustomButton

protocol ProfileDisplayLogic: AnyObject {
    func displayProfile(viewModel: ProfileModels.FetchProfile.ViewModel)
}

final class ProfileViewController: UIViewController {
    
    // MARK: - VIP Properties
    
    var interactor: ProfileBusinessLogic?
    var router: (ProfileRoutingLogic & ProfileDataPassing)?
    
    // MARK: - Outlet
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var logoutButton: RedButton!
    
    // MARK: - Property
    
    var displayedProfile: ProfileModels.FetchProfile.ViewModel?
    
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
        
        if #available(iOS 13.0, *) {
            let darkModeEnabled = UserDefaults.standard.bool(forKey: "darkModeEnabled")
            darkModeSwitch.isOn = darkModeEnabled
        }
        
        setupButtonUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor?.fetchProfile()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupButtonUI() {
        logoutButton.setupButtonText(text: "Log Out")
    }
    
    // MARK: - Action
    
    @IBAction func darkModeSwitch(_ sender: UISwitch) {
        if #available(iOS 13.0, *) {
            if sender.isOn {
                (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .dark
                }
                UserDefaults.standard.set(true, forKey: "darkModeEnabled")
            } else {
                (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .light
                }
                UserDefaults.standard.set(false, forKey: "darkModeEnabled")
            }
        }
    }
    
    @IBAction func myBankCardButtonTapped(_ sender: Any) {
        router?.routeToMyBankCards()
    }
    
    @IBAction func linkedInButtonTapped(_ sender: Any) {
        router?.routeToLinkedIn()
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Log Out", message: "Are you sure you want to log out? All your data will be deleted!", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        let okAction = UIAlertAction(title: "Log Out", style: .destructive) { [weak self] (action) in
            guard let self else { return }
            self.interactor?.performLogout { result in
                switch result {
                case .success:
                    KeyChainHelper.shared.delete(service: "movieDB", account: "sessionId")
//                    UserDefaults.standard.removeObject(forKey: "sessionId")
                    self.router?.routeToLoginScreen()
                case .failure(let error):
                    UIAlertHelper.shared.showAlert(title: "Error", message: "An error occurred during the logout process: \(error)", buttonTitle: "OK", on: self)
                }
            }
        }
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - DisplayLogic

extension ProfileViewController: ProfileDisplayLogic {
    func displayProfile(viewModel: ProfileModels.FetchProfile.ViewModel) {
        
        displayedProfile = viewModel
        guard let displayedProfile else { return }
        
        if let posterUrl = ImageUrlHelper.imageUrl(for: displayedProfile.avatarPath) {
            profileImage.load(url: posterUrl)
        }
        
        nameLabel.text = displayedProfile.name
        userNameLabel.text = displayedProfile.username
    }
}
