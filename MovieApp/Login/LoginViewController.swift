//
//  LoginViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 22.07.2023.
//

import UIKit
import CustomButton

protocol LoginDisplayLogic: AnyObject {
    func displayLoginSuccess()
    func displayLoginFailure()
}

final class LoginViewController: UIViewController {
    
    var interactor: LoginBusinessLogic?
    var router: (LoginRoutingLogic & LoginDataPassing)?
    
    // MARK: - Outlets
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: RedButton!
    @IBOutlet weak var signupButton: RedButton!
    
    // MARK: - Object lifecycle
    
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
        
        if let data = KeyChainHelper.shared.read(service: "movieDB", account: "sessionId"),
           let sessionId = String(data: data, encoding: .utf8) {
            APIConstants.sessionId = sessionId
            router?.routeToApp()
        }
        
        setupButtonUI()
        setupDismissKeyboardOnTap()
        
//        if UserDefaults.standard.string(forKey: "sessionId") != nil {
//            let sessionId = UserDefaults.standard.string(forKey: "sessionId")
//            APIConstants.sessionId = sessionId
//            router?.routeToApp()
//        }
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupButtonUI() {
        loginButton.setupButtonText(text: "Log In")
        signupButton.setupButtonText(text: "Sign Up")
    }
    
    // MARK: - Action
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        interactor?.login(username: userNameTextField.text, password: passwordTextField.text)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        router?.routeToSignUp()
    }
    @IBAction func resetPasswordButtonTapped(_ sender: Any) {
        router?.routeToResetPassword()
    }
}

// MARK: - DisplayLogic

extension LoginViewController: LoginDisplayLogic {
    func displayLoginSuccess() {
        router?.routeToApp()
    }
    
    func displayLoginFailure() {
        DispatchQueue.main.async {
            UIAlertHelper.shared.showAlert(
                title: "Error",
                message: "The username or password is incorrect. Please try again.",
                buttonTitle: "OK",
                on: self
            )
        }
    }
}
