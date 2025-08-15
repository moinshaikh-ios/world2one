//
//  ChooseOptionViewController.swift
//  World2one
//
//  Created by Moin on 28/01/2025.
//

import UIKit

class ChooseOptionViewController: UIViewController {

    @IBOutlet weak var termsAndConditionLbl: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let text = "By joining you are accept and agree to the World2One’s Terms Of Use and Privacy Policy"
        
        termsAndConditionLbl.setAttributedTextWithLinks(
            text: text,
            linkText1: "Terms Of Use", linkURL1: "terms",
            linkText2: "Privacy Policy", linkURL2: "privacy",
            fontName: "Poppins-Regular",
            fontSize: 14,
            textColor: .black,
            lineSpacing: 5,
            alignment: .center
        )

    }


    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func loginBtnTapped(_ sender: UIButton) {
        let vc = LoginViewController.getVC(.auth)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func createAnAccountBtnTapped(_ sender: UIButton) {
        let vc = RegisterViewController.getVC(.auth)
            vc.isComeFrom = "choose"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tryOutAppBtnTapped(_ sender: UIButton) {
        RegisterApi(Username: "", Password: "", ConfirmPassword: "", AutoCreate: "true")
  
    }

  

}

extension ChooseOptionViewController {
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
