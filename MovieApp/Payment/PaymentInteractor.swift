//
//  PaymentInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 15.07.2023.
//

import Foundation
import UIKit

protocol PaymentBusinessLogic: AnyObject {
    func getMovie()
    func validateCard(request: PaymentModels.FetchPayment.Request)
    func shouldChangeCharactersInTextField(textField: UITextField, range: NSRange, string: String) -> Bool
    func textFieldDidChangeSelection(textFields: [UITextField], button: UIButton)
    //    func updatePaymentDetails(with details: PaymentModels.FetchPayment.ViewModel)
    func getbankCardDetails()
}

protocol PaymentDataStore: AnyObject {
    var paymentDetails: PaymentModels.FetchPayment.ViewModel? { get set }
}

final class PaymentInteractor: PaymentBusinessLogic, PaymentDataStore {
    
    var presenter: PaymentPresentationLogic?
    var worker: PaymentWorkingLogic = PaymentWorker()
    
    var paymentDetails: PaymentModels.FetchPayment.ViewModel?
    
    func getMovie() {
        guard let paymentDetails else { return }
        presenter?.presentMovie(paymentDetails: paymentDetails)
    }
    
    func validateCard(request: PaymentModels.FetchPayment.Request) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        if worker.checkTicketExists(paymentDetails: paymentDetails) {
            presenter?.presentTicketExistAlert()
            return
        }
        
        let fetchRequest = worker.createFetchRequest(request: request)
        
        do {
            let bankCards = try context.fetch(fetchRequest)
            let isValid = !bankCards.isEmpty
            let response = PaymentModels.FetchPayment.Response(isValid: isValid)
            presenter?.presentCardValidationResult(response: response)
            
            if response.isValid {
                saveMovieTicket()
            }
        } catch {
            print("Could not fetch card details. \(error)")
        }
    }
    
    func saveMovieTicket() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        guard (worker.createMovieTicket(paymentDetails: paymentDetails)) != nil else {
            print("Failed to create ticket in Interactor.")
            return
        }
        
        do {
            try context.save()
            print("Ticket saved successfully in Interactor.")
        } catch {
            print("Failed to save ticket in Interactor: \(error)")
        }
    }
    
    func shouldChangeCharactersInTextField(textField: UITextField, range: NSRange, string: String) -> Bool {
        switch textField.accessibilityIdentifier {
        case Constants.textFieldAccessibilityIdentifier.nameCardTextField:
            return handleNameCardTextField(textField: textField, range: range, string: string)
        case Constants.textFieldAccessibilityIdentifier.cardNumberTextField:
            return handleCardNumberTextField(textField: textField, range: range, string: string)
        case Constants.textFieldAccessibilityIdentifier.dateExpireTextField:
            return handleDateExpireTextField(textField: textField, range: range, string: string)
        case Constants.textFieldAccessibilityIdentifier.cvvTextField:
            return handleCVVTextField(textField: textField, range: range, string: string)
        default:
            return true
        }
    }
    
    func handleNameCardTextField(textField: UITextField, range: NSRange, string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        textField.text = updatedText.capitalized
        return false
    }
    
    func handleCardNumberTextField(textField: UITextField, range: NSRange, string: String) -> Bool {
        let previousText = textField.text ?? ""
        let updatedText = (previousText as NSString).replacingCharacters(in: range, with: string)
        
        // Kullanıcının sadece rakam girmesini sağlamak için kontrol ediyoruz
        if !isNumericString(string) {
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
    
    func handleDateExpireTextField(textField: UITextField, range: NSRange, string: String) -> Bool {
        let previousText = textField.text ?? ""
        let updatedText = (previousText as NSString).replacingCharacters(in: range, with: string)
        
        // Kullanıcının sadece rakam girmesini sağlamak için kontrol ediyoruz
        if !isNumericString(string) {
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
    
    func handleCVVTextField(textField: UITextField, range: NSRange, string: String) -> Bool {
        if !isNumericString(string) {
            return false
        }
        
        // Yeni metni alıyoruz ve karakter sayısını kontrol ediyoruz
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            let cvvCount = updatedText.count
            
            // Sadece 3 rakam girilmesini sağlamak için kontrol ediyoruz
            if cvvCount > 3 {
                return false
            }
        }
        return true
    }
    
    func isNumericString(_ string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldDidChangeSelection(textFields: [UITextField], button: UIButton) {
        guard let nameCardText = textFields[0].text, !nameCardText.isEmpty,
              let cardNumberText = textFields[1].text, cardNumberText.count == 19,
              let dateExpireText = textFields[2].text, dateExpireText.count == 5,
              let cvvText = textFields[3].text, cvvText.count == 3 else {
            button.isEnabled = false
            button.backgroundColor = .systemGray
            return
        }
        
        button.isEnabled = true
        button.backgroundColor = UIColor(named: "buttonRed")
    }
    
//    func updatePaymentDetails(with details: PaymentModels.FetchPayment.ViewModel) {
//        self.paymentDetails = details
//    }
    
    func getbankCardDetails() {
        guard let paymentDetails else { return }
        presenter?.presentBankCardDetails(bankCardDetails: paymentDetails)
    }
}
