//
//  PaymentViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 15.07.2023.
//

import UIKit
import CustomButton

protocol PaymentDisplayLogic: AnyObject {
    func displayFetchedMovie(viewModel: PaymentModels.FetchPayment.ViewModel)
    func displayFetchedBankCardDetails(viewModel: PaymentModels.FetchPayment.ViewModel)
    func displayCardValidationResult(viewModel: PaymentModels.FetchPayment.ViewModel)
}

final class PaymentViewController: UIViewController {
    
    // MARK: - VIP Properties
    
    var interactor: PaymentBusinessLogic?
    var router: (PaymentRoutingLogic & PaymentDataPassing)?
    
    // MARK: - Outlet
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var seatLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameCardTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var dateExpireTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var placeOrderButton: RedButton!
    
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
        
        navigationItem.title = "Payment"
        setupTextField()
        setupDismissKeyboardOnTap()
        setupButtonUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.getMovie()
        interactor?.getbankCardDetails()
        //        placeOrderButton.isEnabled = false
        //        placeOrderButton.backgroundColor = .systemGray
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = PaymentInteractor()
        let presenter = PaymentPresenter()
        let router = PaymentRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupTextField() {
        nameCardTextField.delegate = self
        cardNumberTextField.delegate = self
        dateExpireTextField.delegate = self
        cvvTextField.delegate = self
    }
    
    private func setupButtonUI() {
        placeOrderButton.setupButtonText(text: "Place Order")
//        placeOrderButton.isEnabled = false
//        placeOrderButton.backgroundColor = .systemGray
    }
    
    // MARK: - Actions
    
    @IBAction func placeOrderButtonTapped(_ sender: Any) {
        let request = PaymentModels.FetchPayment.Request(
            nameCard: nameCardTextField.text,
            cardNumber: cardNumberTextField.text,
            dateExpire: dateExpireTextField.text,
            cvv: cvvTextField.text)
        interactor?.validateCard(request: request)
    }
    
    @IBAction func addBankCardTapped(_ sender: Any) {
        router?.routeToMyBankCards()
    }
}

// MARK: - DisplayLogic

extension PaymentViewController: PaymentDisplayLogic {
    func displayFetchedMovie(viewModel: PaymentModels.FetchPayment.ViewModel) {
        if let posterUrl = ImageUrlHelper.imageUrl(for: viewModel.selectedMovieImage ?? "") {
            posterImage.load(url: posterUrl)
        }
        
        titleLabel.text = viewModel.selectedMovieTitle
        timeLabel.text = viewModel.selectedTime
        dateLabel.text = viewModel.selectedDate
        seatLabel.text = "Seat: \(viewModel.chooseSeat?.joined(separator: ", ") ?? "")"
        priceLabel.text = "$ " + String(format: "%.2f", viewModel.totalAmount ?? .zero)
    }
    
    func displayFetchedBankCardDetails(viewModel: PaymentModels.FetchPayment.ViewModel) {
        nameCardTextField.text = viewModel.cardHolder
        cardNumberTextField.text = viewModel.cardNumber
        dateExpireTextField.text = viewModel.cardExpires
        cvvTextField.text = viewModel.cvv
        
        interactor?.textFieldDidChangeSelection(
            textFields: [nameCardTextField,
                         cardNumberTextField,
                         dateExpireTextField,
                         cvvTextField],
            button: placeOrderButton)
    }
    
    func displayCardValidationResult(viewModel: PaymentModels.FetchPayment.ViewModel) {
        if let message = viewModel.message {
            UIAlertHelper.shared.showAlert(
                title: viewModel.title,
                message: message,
                buttonTitle: viewModel.buttonTitle,
                on: self)
        } else {
            router?.routeToCongrats()
        }
    }
}

// MARK: - UITextFieldDelegate

extension PaymentViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return interactor?.shouldChangeCharactersInTextField(textField: textField, range: range, string: string) ?? true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        interactor?.textFieldDidChangeSelection(
            textFields: [nameCardTextField,
                         cardNumberTextField,
                         dateExpireTextField,
                         cvvTextField],
            button: placeOrderButton)
    }
}
