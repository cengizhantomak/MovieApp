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
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available (iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        // Tarih aralığını belirlemek için minimumDate ve maximumDate'i ayarla
        let currentDate = Date()
        datePicker.minimumDate = currentDate
        
        let thirtyDaysFromNow = Calendar.current.date(byAdding: .day, value: 90, to: currentDate)
        datePicker.maximumDate = thirtyDaysFromNow
        
        dateTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        timeTextField.delegate = self
        theatreTextField.delegate = self
        timeTextField.inputView = pickerView
        theatreTextField.inputView = pickerView
        
        setupToolbar()
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
        guard let dateText = dateTextField.text, !dateText.isEmpty,
              let timeText = timeTextField.text, !timeText.isEmpty,
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
        if pickerView == theatreTextField.inputView {
            return displayedGetTicketData.theaters.count // Dizi eleman sayısı kadar satır olacak
        } else if pickerView == timeTextField.inputView {
            return displayedGetTicketData.times.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == theatreTextField.inputView {
            return displayedGetTicketData.theaters[row] // Her bir satır için veriyi döndürme
        } else if pickerView == timeTextField.inputView {
            return displayedGetTicketData.times[row]
        } else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == theatreTextField.inputView {
            theatreTextField.text = displayedGetTicketData.theaters[row] // Seçilen veriyi TextField'e yerleştirme
        } else if pickerView == timeTextField.inputView {
            timeTextField.text = displayedGetTicketData.times[row]
        }
    }
}
