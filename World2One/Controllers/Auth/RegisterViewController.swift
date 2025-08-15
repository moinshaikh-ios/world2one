//
//  RegisterViewController.swift
//  World2one
//
//  Created by Moin on 29/01/2025.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var createUsernameFloatingLabel: UILabel!
    @IBOutlet weak var createUsernameTextField: UITextField!
    @IBOutlet weak var createUsernameContainerView: UIView!
    @IBOutlet weak var enterPasswordFloatingLabel: UILabel!
    @IBOutlet weak var enterPasswordTextField: UITextField!
    @IBOutlet weak var enterPasswordContainerView: UIView!
    @IBOutlet weak var confirmPasswordFloatingLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordContainerView: UIView!
    
    @IBOutlet weak var loginTV: UITextView!
    
    var url = ""
    var isComeFrom : String? {
    didSet {
        if isComeFrom == "login" {
          url = "login"
        }else {
          url = "choose"
        }
    }
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUsernameTextField.delegate = self
        enterPasswordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
    createUsernameTextField.setupFloatingLabel(containerView: createUsernameContainerView, floatingLabel: createUsernameFloatingLabel)
    enterPasswordTextField.setupFloatingLabel(containerView: enterPasswordContainerView, floatingLabel: enterPasswordFloatingLabel)
        enterPasswordTextField.enablePasswordToggle()
    confirmPasswordTextField.setupFloatingLabel(containerView: confirmPasswordContainerView, floatingLabel: confirmPasswordFloatingLabel)
        confirmPasswordTextField.enablePasswordToggle()

        
        loginTV.setAttributedTextWithLinks(
            text: "Already have an account? Login",
            linkText1: "Login", linkURL1: url,
            fontName: "Poppins-Regular",
            fontSize: 14,
            textColor: UIColor(hex: "#212D40") ?? .black,
            lineSpacing: 5,
            alignment: .center
        )
    }
    
    func validation() -> Bool {
        if let errorMessage = Utility().validate(textField: createUsernameTextField, fieldName: "Create User Name", validationType: .minLength(4)) {
            Utility.showWarningAlert(message: errorMessage)
            return false
        }
        
        if let errorMessage = Utility().validate(textField: enterPasswordTextField, fieldName: "Enter Password", validationType: .password) {
            Utility.showWarningAlert(message: errorMessage)
            return false
        }
        
        if let errorMessage = Utility().validate(textField: confirmPasswordTextField, fieldName: "Confirm Password", validationType: .confirmPassword(originalPassword: enterPasswordTextField.text ?? "")) {
            Utility.showWarningAlert(message: errorMessage)
            return false
        }
        
        return true
    }
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func RegisterBtnTapped(_ sender: UIButton) {
        if validation() {
            RegisterApi(Username: createUsernameTextField.text ?? "", Password: enterPasswordTextField.text ?? "", ConfirmPassword: confirmPasswordTextField.text ?? "", AutoCreate: "")
        }
    }

}

extension RegisterViewController {
    
    func RegisterApi(Username:String,Password:String,ConfirmPassword:String,AutoCreate:String) {
        APIManager.shared.register(Username: Username, Password: Password, ConfirmPassword: ConfirmPassword, AutoCreate: AutoCreate) { result in
            switch result {
            case .success(let response):
                if response.success == false {
                    Utility.showWarningAlert(message: response.message ?? "")
                }else {
                    AppDefault.currentUser = response.registerData
                    AppDefault.accessToken = response.registerData?.accessToken ?? ""
                    AppDefault.username = response.registerData?.username ?? ""
                    let vc = OnBoardingViewController.getVC(.onboard)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                Utility.showWarningAlert(message:"\(error)")
            }
        }
    }
    
}



extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss keyboard
        return true
    }
}
