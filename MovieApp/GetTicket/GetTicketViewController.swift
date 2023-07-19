//
//  GetTicketViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import UIKit

protocol GetTicketDisplayLogic: AnyObject {
    func displayFetchedMovie(viewModel: GetTicketModels.FetchGetTicket.ViewModel)
    func displayDateTheater()
    func didSelectDate(date: Date)
    func didSelectTheater(theater: String)
}

final class GetTicketViewController: UIViewController {
    
    // MARK: - VIP Properties
    
    var interactor: GetTicketBusinessLogic?
    var router: (GetTicketRoutingLogic & GetTicketDataPassing)?
    
    // MARK: - Outlet
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var theatreTextField: UITextField!
    @IBOutlet weak var getTicketButton: UIButton!
    
    // MARK: - Property
    
    let data = ["Kadikoy", "Besiktas", "Taksim", "Sisli", "Avcilar"]
    
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
        
        interactor?.getMovie()
        setupDateTextField()
        setupTheaterTextField()
        setupDismissKeyboardOnTap()
        getTicketButton.isEnabled = false
        getTicketButton.backgroundColor = .systemGray
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = GetTicketInteractor()
        let presenter = GetTicketPresenter()
        let router = GetTicketRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupDateTextField() {
        dateTextField.delegate = self
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available (iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        dateTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    
    private func setupTheaterTextField() {
        theatreTextField.delegate = self
        let pickerView = UIPickerView()
        theatreTextField.inputView = pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    // MARK: - Actions
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func getTicketButtonTapped(_ sender: Any) {
        guard let selectedDate = dateTextField.text,
              let selectedTheater = theatreTextField.text else {
            return
        }
        
        interactor?.selectedDateTheater(date: selectedDate, theater: selectedTheater)
    }
}

// MARK: - DisplayLogic

extension GetTicketViewController: GetTicketDisplayLogic {
    func displayFetchedMovie(viewModel: GetTicketModels.FetchGetTicket.ViewModel) {
        navigationItem.title = viewModel.selectedMovieTitle
    }
    
    func didSelectDate(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateTextField.text = dateFormatter.string(from: date)
    }
    
    func didSelectTheater(theater: String) {
        theatreTextField.text = theater
    }
    
    func displayDateTheater() {
        router?.routeToChooseSeat()
    }
}

// MARK: - UITextField

extension GetTicketViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let dateText = dateTextField.text, !dateText.isEmpty,
              let theaterText = theatreTextField.text, !theaterText.isEmpty else {
            getTicketButton.isEnabled = false
            return
        }
        
        getTicketButton.isEnabled = true
        getTicketButton.backgroundColor = UIColor(named: "buttonRed")
    }
}

// MARK: - UIPickerView

extension GetTicketViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Tek bir sütun kullanacağız
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count // Dizi eleman sayısı kadar satır olacak
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row] // Her bir satır için veriyi döndürme
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        theatreTextField.text = data[row] // Seçilen veriyi TextField'e yerleştirme
    }
}
