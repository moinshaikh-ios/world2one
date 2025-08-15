//
//  WelcomeMyWorldViewController.swift
//  World2one
//
//  Created by Moin on 28/01/2025.
//

import UIKit

class WelcomeMyWorldViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

    }
    
    @IBAction func enterMyWorldBtnTapped(_ sender: UIButton) {
        let vc = ChooseOptionViewController.getVC(.auth)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
