//
//  GetTicketViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 6.07.2023.
//

import UIKit
import CustomButton

protocol GetTicketDisplayLogic: AnyObject {
    func displayFetchedMovie(viewModel: GetTicketModels.FetchGetTicket.ViewModel)
    func displayDateTheater()
//    func didSelectDate(date: Date)
//    func didSelectTheater(theater: String)
}

final class GetTicketViewController: UIViewController {
    
    // MARK: - VIP Properties
    
    var interactor: GetTicketBusinessLogic?
    var router: (GetTicketRoutingLogic & GetTicketDataPassing)?
    
    // MARK: - Outlet
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var theatreTextField: UITextField!
    @IBOutlet weak var getTicketButton: RedButton!
    
    // MARK: - Property
    
    let displayedGetTicketData = GetTicketModels.FetchGetTicket.GetTicketData()
    
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
        setupTextField()
        setupPicker()
        setupDismissKeyboardOnTap()
        setupButtonUI()
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
    
    private func setupTextField() {
        dateTextField.delegate = self
        timeTextField.delegate = self
        theatreTextField.delegate = self
    }
    
    private func setupPicker() {
        setupDatePicker()
        setupTimePicker()
        setupTheatrePicker()
        setupToolbar()
    }
    
    private func setupDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available (iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        // Tarih aralığını belirlemek için minimumDate ve maximumDate'i ayarla
        guard let dateRange = interactor?.getDateRange(days: 90) else { return }
        datePicker.minimumDate = dateRange.minDate
        datePicker.maximumDate = dateRange.maxDate
        
        dateTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    
    private func setupTimePicker() {
        let timePickerView = UIPickerView()
        timePickerView.dataSource = self
        timePickerView.delegate = self
        timeTextField.inputView = timePickerView
    }
    
    private func setupTheatrePicker() {
        let theatrePickerView = UIPickerView()
        theatrePickerView.dataSource = self
        theatrePickerView.delegate = self
        theatreTextField.inputView = theatrePickerView
    }
    
    private func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker))
        
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        dateTextField.inputAccessoryView = toolbar
        timeTextField.inputAccessoryView = toolbar
        theatreTextField.inputAccessoryView = toolbar
    }
    
    private func setupButtonUI() {
        getTicketButton.setupButtonText(text: "Get Ticket")
        getTicketButton.isEnabled = false
        getTicketButton.backgroundColor = .systemGray
    }
    
    // MARK: - Actions
    
    @objc func donePicker() {
        if dateTextField.isFirstResponder {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM, yyyy"
            if let datePicker = self.dateTextField.inputView as? UIDatePicker {
                self.dateTextField.text = formatter.string(from: datePicker.date)
            }
            self.dateTextField.endEditing(true)
        } else if timeTextField.isFirstResponder {
            if let pickerView = self.timeTextField.inputView as? UIPickerView {
                self.timeTextField.text = displayedGetTicketData.times[pickerView.selectedRow(inComponent: 0)]
            }
            self.timeTextField.endEditing(true)
        } else if theatreTextField.isFirstResponder {
            if let pickerView = self.theatreTextField.inputView as? UIPickerView {
                self.theatreTextField.text = displayedGetTicketData.theaters[pickerView.selectedRow(inComponent: 0)]
            }
            self.theatreTextField.endEditing(true)
        }
    }
    
    @objc func cancelPicker() {
        self.view.endEditing(true)
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func getTicketButtonTapped(_ sender: Any) {
        guard let selectedDate = dateTextField.text,
              let selectedTime = timeTextField.text,
              let selectedTheater = theatreTextField.text else {
            return
        }
        
        interactor?.selectedDateTheater(date: selectedDate, time: selectedTime, theater: selectedTheater)
    }
}

// MARK: - DisplayLogic

extension GetTicketViewController: GetTicketDisplayLogic {
    func displayFetchedMovie(viewModel: GetTicketModels.FetchGetTicket.ViewModel) {
        navigationItem.title = viewModel.selectedMovieTitle
    }
    
//    func didSelectDate(date: Date) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd MMMM yyyy"
//        dateTextField.text = dateFormatter.string(from: date)
//    }
//
//    func didSelectTheater(theater: String) {
//        theatreTextField.text = theater
//    }
    
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
        interactor?.textFieldDidChangeSelection(
            textFields: [dateTextField,
                         timeTextField,
                         theatreTextField],
            button: getTicketButton)
    }
}

// MARK: - UIPickerView

extension GetTicketViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Tek bir sütun kullanacağız
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == theatreTextField.inputView {
            return displayedGetTicketData.theaters.count
        } else if pickerView == timeTextField.inputView {
            return displayedGetTicketData.times.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == theatreTextField.inputView {
            return displayedGetTicketData.theaters[row]
        } else if pickerView == timeTextField.inputView {
            return displayedGetTicketData.times[row]
        } else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == theatreTextField.inputView {
            theatreTextField.text = displayedGetTicketData.theaters[row]
        } else if pickerView == timeTextField.inputView {
            timeTextField.text = displayedGetTicketData.times[row]
        }
    }
}
