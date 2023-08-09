//
//  AddBankCardInteractor.swift
//  MovieApp
//
//  Created by Cengizhan Tomak on 16.07.2023.
//

import Foundation
import UIKit
import CoreData

protocol AddBankCardBusinessLogic: AnyObject {
    func saveBankCard(cardName: String, cardNumber: String, expiryDate: String, cvv: String, viewController: UIViewController)
    func shouldChangeCharactersInTextField(textField: UITextField, range: NSRange, string: String) -> Bool
    func handleTextFieldChange(textFields: [UITextField], button: UIButton)
}

protocol AddBankCardDataStore: AnyObject {
    
}

final class AddBankCardInteractor: AddBankCardBusinessLogic, AddBankCardDataStore {
    
    var presenter: AddBankCardPresentationLogic?
    var worker: AddBankCardWorkingLogic = AddBankCardWorker()
    
    func saveBankCard(cardName: String, cardNumber: String, expiryDate: String, cvv: String, viewController: UIViewController) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        if checkCardExistence(cardNumber: cardNumber, context: context) {
            // Kart zaten var
            print("This card already exists in CoreData.")
            // TODO: - UIAlertHelper will be edited
            UIAlertHelper.shared.showAlert(
                title: "Error",
                message: "This card already exists.",
                buttonTitle: "OK",
                on: viewController)
        } else {
            // Kart mevcut değil, CoreData'ya kaydedin
            let newBankCard = BankCard(context: context)
            
            newBankCard.nameCard = cardName
            newBankCard.cardNumber = cardNumber
            newBankCard.dateExpire = expiryDate
            newBankCard.cvv = cvv
            newBankCard.timestamp = Date()
            newBankCard.id = UUID()
            
            do {
                try context.save()
                print("Bank Card saved successfully!")
                // TODO: - UIAlertHelper will be edited
                UIAlertHelper.shared.showAlert(
                    title: "Success",
                    message: "Bank Card saved successfully!",
                    buttonTitle: "OK",
                    on: viewController
                )
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                // TODO: - UIAlertHelper will be edited
                UIAlertHelper.shared.showAlert(
                    title: "Error",
                    message: "Could not save. \(error), \(error.userInfo)",
                    buttonTitle: "OK",
                    on: viewController
                )
            }
        }
    }
    
    func checkCardExistence(cardNumber: String, context: NSManagedObjectContext) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BankCard")
        request.predicate = NSPredicate(format: "cardNumber = %@", cardNumber)
        request.fetchLimit = 1
        
        do {
            let result = try context.fetch(request)
            return !result.isEmpty
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
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
    
    func handleTextFieldChange(textFields: [UITextField], button: UIButton) {
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
}
