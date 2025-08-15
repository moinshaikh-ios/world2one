//
//  MagzinesViewController.swift
//  World2one
//
//  Created by Moin on 03/02/2025.
//

import UIKit

class MagzinesViewController: UIViewController {

    @IBOutlet weak var magzinesTblV: UITableView!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var postAndOffersBtn: UIButton!
    @IBOutlet weak var headerImg: UIImageView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var profileScrollView: UIScrollView!
    @IBOutlet weak var postandOfferView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileDescription: UILabel!
    @IBOutlet weak var removeFromWorldBtnLbl: UILabel!
    
    var offerData : [Offer] = []
    var fullOffer : OffersDataModel?
    var headerimg:String?
    var headerlbl:String?
    var isLinked : Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerImg.pLoadImage(url: headerimg ?? "")
        self.headerLbl.text = headerlbl
        
        profileBtn.backgroundColor = UIColor.primary
        postAndOffersBtn.backgroundColor = .white
        profileBtn.tintColor = .white
        postAndOffersBtn.tintColor = UIColor(hex: "#292D34")
        
//        profileImage.pLoadImage(url: APIBaseUrl.ImgUrl + (fullOffer?.imageURL ?? ""))
//        profileDescription.text = fullOffer?.description
        marchentApi(Key: fullOffer?.key ?? "", token: AppDefault.accessToken)
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileBtnTapeed(_ sender: UIButton) {
        postandOfferView.isHidden = true
        profileScrollView.isHidden =  false
        profileBtn.backgroundColor = UIColor.primary
        postAndOffersBtn.backgroundColor = .white
        profileBtn.tintColor = .white
        postAndOffersBtn.tintColor = UIColor(hex: "#292D34")
    }
    @IBAction func postAndOffersBtnTapped(_ sender: UIButton) {
        profileScrollView.isHidden =  true
        postandOfferView.isHidden = false
        postAndOffersBtn.backgroundColor = UIColor.primary
        profileBtn.backgroundColor = .white
        postAndOffersBtn.tintColor = .white
        profileBtn.tintColor = UIColor(hex: "#292D34")
    }
    
//    @IBAction func goToWebPageBtnTapped(_ sender: UIButton) {
//        
//        Utility.showMultipleChoiceAlert(message: "You are leaving the W2o application and its anonymity for the selected website. Would you like to continue?", firstHandler:  {
//            if let url = URL(string: self.fullOffer?.reed ?? ""), UIApplication.shared.canOpenURL(url) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            } else {
//                print("Invalid URL")
//            }
//        }, firstBtnTitle: "OK")
//        
// 
//    }
    
    @IBAction func removeFromMyWorldBtnTapped(_ sender: UIButton) {
        if isLinked == true {
            MarchentAddandRemoveApi(Key: fullOffer?.key ?? "", token: AppDefault.accessToken, add: "", remove: "true")
        }else {
            MarchentAddandRemoveApi(Key: fullOffer?.key  ?? "", token: AppDefault.accessToken, add: "true", remove: "")
        }
    }

    
}

extension MagzinesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompaniesTableViewCell", for: indexPath) as! CompaniesTableViewCell
        let data = offerData[indexPath.row]
        cell.img.pLoadImage(url: APIBaseUrl.ImgUrl
                            + (data.imageURL ?? ""))
        cell.titleLbl.text = data.name ?? ""
        cell.descriptionLbl.text = data.description ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = offerData[indexPath.row]

        let vc = MagazinesDetailViewController.getVC(.home)
          vc.key = data.key 
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension MagzinesViewController {
    
    func MarchentAddandRemoveApi(Key: String, token: String, add: String, remove: String) {
        APIManager.shared.MarchentAddandRemove(Key: Key, token: token, add: add, remove: remove){ result in
            switch result {
            case .success(let res):
                Utility.showWarningAlert(message:res.resultDescription ?? "") {
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                Utility.showWarningAlert(message:"\(error)")
            }
        }
    }
    
    func marchentApi(Key:String,token:String) {
        APIManager.shared.Marchent(Key: Key, token: token){ result in
            switch result {
            case .success(let res):
             print(res)
                self.isLinked = res.isLinked ?? false
                if res.isLinked == true {
                    self.removeFromWorldBtnLbl.text = "Remove From My World"
                }else{
                    self.removeFromWorldBtnLbl.text = "Add To My World"
                }
                
                self.profileImage.pLoadImage(url: APIBaseUrl.ImgUrl + (res.imageUrl1 ?? ""))
                self.profileDescription.text = res.description

            case .failure(let error):
                Utility.showWarningAlert(message:"\(error)")
            }
        }
    }
}
