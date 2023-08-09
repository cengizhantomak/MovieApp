//
//  AddBankCardViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 16.07.2023.
//

import UIKit
import CustomButton

protocol AddBankCardDisplayLogic: AnyObject {
    
}

final class AddBankCardViewController: UIViewController {
    
    // MARK: - VIP Properties
    
    var interactor: AddBankCardBusinessLogic?
    var router: (AddBankCardRoutingLogic & AddBankCardDataPassing)?
    
    // MARK: - Outlet
    
    @IBOutlet weak var nameCardTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var dateExpireTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var addCardButton: RedButton!
    
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
        
        navigationItem.title = "Add Bank Card"
        setupTextField()
        setupDismissKeyboardOnTap()
        setupButtonUI()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = AddBankCardInteractor()
        let presenter = AddBankCardPresenter()
        let router = AddBankCardRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupTextField() {
        nameCardTextField.delegate = self
        nameCardTextField.accessibilityIdentifier = Constants.textFieldAccessibilityIdentifier.nameCardTextField
        cardNumberTextField.delegate = self
        cardNumberTextField.accessibilityIdentifier = Constants.textFieldAccessibilityIdentifier.cardNumberTextField
        dateExpireTextField.delegate = self
        dateExpireTextField.accessibilityIdentifier = Constants.textFieldAccessibilityIdentifier.dateExpireTextField
        cvvTextField.delegate = self
        cvvTextField.accessibilityIdentifier = Constants.textFieldAccessibilityIdentifier.cvvTextField
    }
    
    private func setupButtonUI() {
        addCardButton.setupButtonText(text: "Add Card")
        addCardButton.isEnabled = false
        addCardButton.backgroundColor = .systemGray
    }
    
    // MARK: - Actions
    
    @IBAction func addCardButtonTapped(_ sender: Any) {
        guard let cardName = nameCardTextField.text,
              let cardNumber = cardNumberTextField.text,
              let expiryDate = dateExpireTextField.text,
              let cvv = cvvTextField.text else { return }
        
        interactor?.saveBankCard(cardName: cardName, cardNumber: cardNumber, expiryDate: expiryDate, cvv: cvv, viewController: self)
    }
}

// MARK: - DisplayLogic

extension AddBankCardViewController: AddBankCardDisplayLogic {
    
}

// MARK: - UITextFieldDelegate

extension AddBankCardViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return interactor?.shouldChangeCharactersInTextField(textField: textField, range: range, string: string) ?? true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        interactor?.textFieldDidChangeSelection(textFields: [nameCardTextField,
                                                       cardNumberTextField,
                                                       dateExpireTextField,
                                                       cvvTextField],
                                          button: addCardButton)
    }
}
