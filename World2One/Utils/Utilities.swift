//
//  Utilities.swift
//  World2one
//
//  Created by Moin on 28/01/2025.
//

import Foundation
import UIKit


enum ValidationType {
    case email
    case password
    case nonEmpty
    case minLength(Int)
    case confirmPassword(originalPassword: String)
}


class Utility {


    func validate(textField: UITextField, fieldName: String, validationType: ValidationType) -> String? {
        guard let text = textField.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return "\(fieldName) cannot be empty."
        }
        
        switch validationType {
        case .email:
            return isValidEmail(text) ? nil : "Invalid \(fieldName) format."
            
        case .password:
            return isValidPassword(text) ? nil : "Password should be between 8 and 20 characters and include an uppercase and lowercase letter and a number"
            
        case .nonEmpty:
            return nil // Already checked for non-empty condition
            
        case .minLength(let length):
            return text.count >= length ? nil : "\(fieldName) must be at least \(length) characters long."
        
        case .confirmPassword(let originalPassword):
            return text == originalPassword ? nil : "Confirm Password does not match."
        }
    }

    // MARK: - Email Validation
     func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }

    // MARK: - Password Validation (At least 8 chars, 1 uppercase, 1 lowercase, 1 number)
     func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d@$!%*?&]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegEx).evaluate(with: password)
    }
    
    
    
    class func showWarningAlert(message: String, okayHandler: (()->())? = nil) {
        generateWarningFeedback()
        let alertView = AlertPopup.instanceFromNib()
        alertView.messageLabel.text = message
        alertView.okayAction = okayHandler
        alertView.show()
    }
    
    class func showMultipleChoiceAlert(message: String, firstHandler: (()->())? = nil, secondHandler: (()->())? = nil, firstBtnTitle: String) {
        generateWarningFeedback()
        let alertView = AlertPopupWithMultipleChoice.instanceFromNib()
        alertView.okayButton.setTitle(firstBtnTitle, for: .normal)
        alertView.cancelButton.setTitle("Cancel", for: .normal)
        alertView.messageLabel.text = message
        alertView.firstAction = firstHandler
        alertView.secondAction = secondHandler
        alertView.show()
    }
    
    class func generateWarningFeedback() {
        let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        notificationFeedbackGenerator.prepare()
        notificationFeedbackGenerator.notificationOccurred(.warning)
    }
    
    func formatTime(seconds: Int) -> String {
        let days = seconds / (24 * 3600)
        let hours = (seconds % (24 * 3600)) / 3600
        let minutes = (seconds % 3600) / 60

        return "\(days) Days \(hours) hr \(minutes) min"
    }

    func formatDate(dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC") // Adjust timezone if needed

        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM dd, yy" // Desired format: Jan 22, 25
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
    
    
}




