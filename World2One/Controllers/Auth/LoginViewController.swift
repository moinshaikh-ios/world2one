//
//  LoginViewController.swift
//  World2one
//
//  Created by Moin on 29/01/2025.
//

import UIKit

class LoginViewController: UIViewController{

    @IBOutlet weak var usernameFloatingLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameContainerView: UIView!
    @IBOutlet weak var passwordFloatingLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var savePcheckBtn: UIButton!
    
    @IBOutlet weak var registerNowTV: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self

        usernameTextField.setupFloatingLabel(containerView: usernameContainerView, floatingLabel: usernameFloatingLabel)
        passwordTextField.setupFloatingLabel(containerView: passwordContainerView, floatingLabel: passwordFloatingLabel)
        passwordTextField.enablePasswordToggle()
        savePcheckBtn.enableCheckToggle()
                
        registerNowTV.setAttributedTextWithLinks(
            text: "Don’t have an account? Register Now",
            linkText1: "Register Now", linkURL1: "register",
            fontName: "Poppins-Regular",
            fontSize: 14,
            textColor: UIColor(hex: "#212D40") ?? .black,
            lineSpacing: 5,
            alignment: .center
        )
        
//        usernameTextField.text = "moin4"
//        passwordTextField.text = "Test@123"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func validation() -> Bool {
        if let errorMessage = Utility().validate(textField: usernameTextField, fieldName: "User Name", validationType: .minLength(4)) {
            Utility.showWarningAlert(message: errorMessage)
            return false
        }
        
//        if let errorMessage = Utility().validate(textField: passwordTextField, fieldName: "Password", validationType: .password) {
//            Utility.showWarningAlert(message: errorMessage)
//            return false
//        }
        
        return true
    }
   

    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func LoginBtnTapped(_ sender: UIButton) {
        if validation() {
            loginApi(email: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
        }
    }
    

}



extension LoginViewController {
    
    func loginApi(email:String,password:String) {
        APIManager.shared.login(email: email, password: password) { result in
            switch result {
            case .success(let response):
                
                AppDefault.currentUser = response
                AppDefault.accessToken = response.accessToken ?? ""
                AppDefault.username = response.username ?? ""
                let vc = HomeViewController.getVC(.home)
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                Utility.showWarningAlert(message:"\(error)")
            }
        }
    }
    
}



extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss keyboard
        return true
    }
}
