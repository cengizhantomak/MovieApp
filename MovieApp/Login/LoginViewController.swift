//
//  LoginViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 22.07.2023.
//

import UIKit

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
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
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
    
    // MARK: - Action
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        interactor?.login(username: userNameTextField.text, password: passwordTextField.text)
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
