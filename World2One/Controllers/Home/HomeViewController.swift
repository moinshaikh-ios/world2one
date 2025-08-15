//
//  HomeViewController.swift
//  World2one
//
//  Created by Moin on 03/02/2025.
//

import UIKit

class HomeViewController: UIViewController, DropdownViewDelegate {

    @IBOutlet weak var companiesTblV: UITableView!
    @IBOutlet weak var companiesLbl: UILabel!
    @IBOutlet weak var myWorldLbl: UILabel!
    @IBOutlet weak var notFoundLbl: UILabel!
    
    @IBOutlet weak var accountButton: UIButton!

    var offersData: [OffersDataModel] = []
    var currentPage = 1
    var isLoading = false  
    let pageSize = 40

    private let dropdownView = DropdownView()

    override func viewDidLoad() {
        super.viewDidLoad()
        companiesTblV.delegate = self
        companiesTblV.dataSource = self
        dropdownView.delegate = self

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        offerApi(PageNumber: currentPage, PageSize: pageSize, token: AppDefault.accessToken)
    }
    
    @IBAction func filterBtnTapped(_ sender: UIButton) {
        let vc = FilterViewController.getVC(.home)
        vc.onDismiss = {
            self.currentPage = 1
            self.offersData = []
            self.offerApi(PageNumber: self.currentPage, PageSize: self.pageSize, token: AppDefault.accessToken)
        }
        vc.modalPresentationStyle = .pageSheet
        if #available(iOS 15.0, *), let sheet = vc.sheetPresentationController {
            sheet.detents = [.large()]
        }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func accountBtnTapped(_ sender: UIButton) {
        
        if dropdownView.isHidden {
               dropdownView.showDropdown(below: accountButton, in: view)
           } else {
               dropdownView.hideDropdown()
           }
       }

       func didSelectItem(title: String) {
           print("Selected: \(title)")
           if title == AppDefault.username {
               let vc = ProfileViewController.getVC(.home)
               self.navigationController?.pushViewController(vc, animated: true)
           }else if title == "Register Now" {
               appDelegate.GotoLogin()
           }else if title == "How it Works"  {
               let vc = OnBoardingViewController.getVC(.onboard)
               vc.iscome = "home"
               self.navigationController?.pushViewController(vc, animated: true)
           }else if title == "Logout" {
               Utility.showMultipleChoiceAlert(message: "Do you want to Logout?", firstHandler:  {
                   self.offersData = []
                   AppDefault.resetUserDefault()
                   appDelegate.GotoLogin()
               }, firstBtnTitle: "YES")
           }else if title == "Terms of Service"{
               if let url = URL(string: "https://www.world2one.com/terms/") {
                   UIApplication.shared.open(url, options: [:], completionHandler: nil)
               }
           }else if title == "Privacy Policy" {
               if let url = URL(string: "https://www.world2one.com/privacy/") {
                   UIApplication.shared.open(url, options: [:], completionHandler: nil)
               }
           }
       }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompaniesTableViewCell", for: indexPath) as! CompaniesTableViewCell
        let data = offersData[indexPath.row]
        if data.isGroupSponsor == false {
            cell.contentView.backgroundColor = .white
            cell.contentView.borderColor = UIColor(hex: "#E1E8ED")
            cell.contentView.borderWidth = 1
            cell.descriptionLbl.numberOfLines = 3
            cell.groupSponserImg.isHidden = true
        }else {
            cell.contentView.backgroundColor = UIColor(named: "lightBlue")
            cell.contentView.borderColor = UIColor(named: "primaryColor")
            cell.contentView.borderWidth = 0.5
            cell.descriptionLbl.numberOfLines = 2
            cell.groupSponserImg.isHidden = false
        }
        cell.img.pLoadImage(url: APIBaseUrl.ImgUrl + (data.imageURL ?? ""))
        cell.titleLbl.text = data.name ?? ""
        cell.descriptionLbl.text = data.offers?.first?.name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = offersData[indexPath.row]
        let vc = MagzinesViewController.getVC(.home)
        vc.offerData = data.offers ?? []
        vc.fullOffer = data
        vc.headerimg = APIBaseUrl.ImgUrl + (data.imageURL ?? "")
        vc.headerlbl = data.name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let tableViewHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - tableViewHeight, !isLoading {
            isLoading = true
            currentPage += 1
            offerApi(PageNumber: currentPage, PageSize: pageSize, token: AppDefault.accessToken)
        }
    }
}

extension HomeViewController {
    func offerApi(PageNumber: Int, PageSize: Int, token: String) {
        APIManager.shared.Offers(PageNumber: PageNumber, PageSize: PageSize, token: token) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if response.count > 0 {
                        self.isLoading = false
                    }
                    if PageNumber == 1 {
                        self.offersData = response
                    } else {
                        self.offersData.append(contentsOf: response)
                    }
                    
                    self.notFoundLbl.isHidden = !self.offersData.isEmpty
//                    self.myWorldLbl.text = AppDefault.filterArray2?.title ?? "My World Only"
                    self.companiesLbl.text = "\(self.offersData.count) Companies"
                    self.companiesTblV.reloadData()
                    
                case .failure(let error):
                    Utility.showWarningAlert(message: "\(error)")
                }
            }
        }
    }
    

}
