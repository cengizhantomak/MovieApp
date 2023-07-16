//
//  AddBankCardViewController.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 16.07.2023.
//

import UIKit

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
    @IBOutlet weak var addCardButton: UIButton!
    
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
        addCardButton.isEnabled = false
        addCardButton.backgroundColor = .gray
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
        cardNumberTextField.delegate = self
        dateExpireTextField.delegate = self
        cvvTextField.delegate = self
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
        
        if textField == nameCardTextField {
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            textField.text = updatedText.uppercased()
            return false
        }
        
        if textField == cardNumberTextField {
            let previousText = textField.text ?? ""
            let updatedText = (previousText as NSString).replacingCharacters(in: range, with: string)
            
            // Kullanıcının sadece rakam girmesini sağlamak için kontrol ediyoruz
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            if !allowedCharacters.isSuperset(of: characterSet) {
                return false
            }
            
            // Önceki tüm biçimlendirmeleri kaldırın
            let strippedCardNumber = updatedText.replacingOccurrences(of: " ", with: "")
            
            // Yeni string 16 basamaktan uzun olacaksa, reddedin
            if strippedCardNumber.count > 16 {
                return false
            }
            
            // Kart numarasını biçimlendirin
            var formattedCardNumber = ""
            let chunkSize = 4
            let formattedIndices = stride(from: 0, to: strippedCardNumber.count, by: chunkSize)
            for index in formattedIndices {
                let startIndex = strippedCardNumber.index(strippedCardNumber.startIndex, offsetBy: index)
                let endIndex = strippedCardNumber.index(startIndex, offsetBy: chunkSize, limitedBy: strippedCardNumber.endIndex) ?? strippedCardNumber.endIndex
                let chunk = strippedCardNumber[startIndex..<endIndex]
                formattedCardNumber += "\(chunk) "
            }
            
            // Varsa, sondaki boşluğu kaldırın
            formattedCardNumber = formattedCardNumber.trimmingCharacters(in: .whitespaces)
            
            textField.text = formattedCardNumber
            return false
        }
        
        if textField == dateExpireTextField {
            let previousText = textField.text ?? ""
            let updatedText = (previousText as NSString).replacingCharacters(in: range, with: string)
            
            // Kullanıcının sadece rakam girmesini sağlamak için kontrol ediyoruz
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            if !allowedCharacters.isSuperset(of: characterSet) {
                return false
            }
            
            // Önceki tüm biçimlendirmeleri kaldırın
            let strippedExpirationDate = updatedText.replacingOccurrences(of: "/", with: "")
            
            // Yeni string 4 basamaktan uzun olacaksa, reddedin
            if strippedExpirationDate.count > 4 {
                return false
            }
            
            // Ayın 01 ile 12 arasında olduğundan emin olun
            if strippedExpirationDate.count >= 2 {
                let monthString = String(strippedExpirationDate.prefix(2))
                if let month = Int(monthString), month < 1 || month > 12 {
                    return false
                }
            }
            
            // Yılın 23 ile 30 arasında olduğundan emin olun
            if strippedExpirationDate.count == 4 {
                let yearString = String(strippedExpirationDate.suffix(2))
                if let year = Int(yearString), year < 23 || year > 39 {
                    return false
                }
            }
            
            var formattedExpirationDate = ""
            for (index, character) in strippedExpirationDate.enumerated() {
                // 2 basamaktan sonra eğik çizgi ekleyin
                if index == 2 {
                    formattedExpirationDate.append("/")
                }
                formattedExpirationDate.append(character)
            }
            
            textField.text = formattedExpirationDate
            return false
        }
        
        if textField == cvvTextField {
            // Kullanıcının sadece rakam girmesini sağlamak için kontrol ediyoruz
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            if !allowedCharacters.isSuperset(of: characterSet) {
                return false
            }
            
            // Yeni metni alıyoruz ve karakter sayısını kontrol ediyoruz
            if let text = textField.text,
               let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                let cvvCount = updatedText.count
                
                // Sadece 3 rakam girilmesini sağlamak için kontrol ediyoruz
                if cvvCount > 3 {
                    return false
                }
            }
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let nameCardText = nameCardTextField.text, !nameCardText.isEmpty,
              let cardNumberText = cardNumberTextField.text, cardNumberText.count == 19,
              let dateExpireText = dateExpireTextField.text, dateExpireText.count == 5,
              let cvvText = cvvTextField.text, cvvText.count == 3 else {
            addCardButton.isEnabled = false
            addCardButton.backgroundColor = .gray
            return
        }
        
        addCardButton.isEnabled = true
        addCardButton.backgroundColor = UIColor(red: 0.9, green: 0.1, blue: 0.22, alpha: 1)
    }
}
