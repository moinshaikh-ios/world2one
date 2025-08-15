//
//  ProfileViewController.swift
//  World2One
//
//  Created by Moin on 19/03/2025.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = AppDefault.username
    }
    

    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editProfileBtnTapped(_ sender: UIButton) {
        Utility.showMultipleChoiceAlert(message: "Do you want to Logout?", firstHandler:  {
            AppDefault.resetUserDefault()
            appDelegate.GotoLogin()
        }, firstBtnTitle: "YES")
    }
    
    @IBAction func howItWorkBtnTapped(_ sender: UIButton) {
        let vc = OnBoardingViewController.getVC(.onboard)
        vc.iscome = "home"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func termAndServiceBtnTapped(_ sender: UIButton) {
        if let url = URL(string: "https://www.world2one.com/terms/") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    @IBAction func privacyPolicyBtnTapped(_ sender: UIButton) {
        if let url = URL(string: "https://www.world2one.com/privacy/") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func logoutBtnTapped(_ sender: UIButton) {
        Utility.showMultipleChoiceAlert(message: "Do you want to Logout?", firstHandler:  {
            AppDefault.resetUserDefault()
            appDelegate.GotoLogin()
        }, firstBtnTitle: "YES")
    }


}
