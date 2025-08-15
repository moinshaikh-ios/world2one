//
//  MagazinesDetailViewController.swift
//  World2one
//
//  Created by Moin on 03/02/2025.
//

import UIKit

class MagazinesDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var showMoreBtn: UIButton!

    @IBOutlet weak var timeLeftToBuyLbl: UILabel!
    @IBOutlet weak var timeLeftToBuyLblKey: UILabel!
    @IBOutlet weak var redeemLbl: UILabel!
    @IBOutlet weak var offerstillAvailableLbl: UILabel!
    @IBOutlet weak var removeFromWorldBtnLbl: UILabel!
    
    @IBOutlet weak var termsLbl: UILabel!
    
    @IBOutlet weak var hideView1: UIView!
    @IBOutlet weak var hideView2: UIView!
    @IBOutlet weak var hideView3: UIView!
    @IBOutlet weak var hideView4: UIView!
    @IBOutlet weak var hideView5: UIView!
    @IBOutlet weak var hideView6: UIView!
    @IBOutlet weak var goToHide: UIView!
    
    
    
    var key:String?
    var isTextExpanded = false

    var offerDetailData : OfferDetailModel?
    var isLinked : Bool?
    var Mid :String?
    override func viewDidLoad() {
        super.viewDidLoad()
//        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        offerDetailApi(Key: key ?? "", token: AppDefault.accessToken)
        showMoreBtn.setTitle("Read More", for: .normal)
        showMoreBtn.addTarget(self, action: #selector(toggleDescription), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.willEnterForegroundNotification, object: nil)

    }
    
    @objc func appDidBecomeActive() {
        offerDetailApi(Key: key ?? "", token: AppDefault.accessToken)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func toggleDescription() {
         isTextExpanded.toggle()
        descriptionLbl.numberOfLines = isTextExpanded ? 0 : 7
        showMoreBtn.setTitle(isTextExpanded ? "Read Less" : "Read More", for: .normal)
     }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goToWebPageBtnTapped(_ sender: UIButton) {
        
        Utility.showMultipleChoiceAlert(message: "You are leaving the W2o application and its anonymity for the selected website. Would you like to continue?", firstHandler:  {
            if let url = URL(string: self.offerDetailData?.redeemURL ?? ""), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                self.redeemApi(Key: self.offerDetailData?.key ?? "", token: AppDefault.accessToken)
            } else {
                print("Invalid URL")
            }
        }, firstBtnTitle: "OK")
        
 
    }
    
    @IBAction func removeFromMyWorldBtnTapped(_ sender: UIButton) {
        if isLinked == true {
            MarchentAddandRemoveApi(Key: Mid ?? "", token: AppDefault.accessToken, add: "", remove: "true")
        }else {
            MarchentAddandRemoveApi(Key: Mid ?? "", token: AppDefault.accessToken, add: "true", remove: "")
        }
    }
    
}

extension MagazinesDetailViewController {
    
    func offerDetailApi(Key:String,token:String) {
        APIManager.shared.OffersDetail(Key: Key, token: token) { result in
            switch result {
            case .success(let res):
                self.offerDetailData = res
                if res.isOffer == true {
                    self.hideView1.isHidden = false
                    self.hideView2.isHidden = false
                    self.hideView3.isHidden = false
                    self.hideView4.isHidden = false
                    self.hideView5.isHidden = false
                    self.hideView6.isHidden = false
                    self.descriptionLbl.numberOfLines = 7
                    
                }else {
                    self.hideView1.isHidden = true
                    self.hideView2.isHidden = true
                    self.hideView3.isHidden = true
                    self.hideView4.isHidden = true
                    self.hideView5.isHidden = true
                    self.hideView6.isHidden = true
                    self.descriptionLbl.numberOfLines = 0
                }
                
                self.mainImg.pLoadImage(url: APIBaseUrl.ImgUrl + (res.imageURL ?? ""))
                self.nameLbl.text = res.name
                self.descriptionLbl.text = res.description
                
                if res.isAvailableInFuture == true {
                    self.timeLeftToBuyLbl.text = Utility().formatTime(seconds: res.availableIn ?? 0)
                    self.timeLeftToBuyLbl.textColor = .red
                    self.timeLeftToBuyLblKey.textColor = .red.withAlphaComponent(0.8)
                    self.timeLeftToBuyLblKey.text = "Available In"
                    self.goToHide.isHidden = true
                }else{
                    self.timeLeftToBuyLbl.text = Utility().formatTime(seconds: res.timeLeft ?? 0)
                    self.timeLeftToBuyLbl.textColor = UIColor(hex: "212D40")
                    self.timeLeftToBuyLblKey.textColor = UIColor(hex: "212D40")?.withAlphaComponent(0.8)
                    self.timeLeftToBuyLblKey.text = "Time Left to Buy"
                    self.goToHide.isHidden = false
                }
                
                self.redeemLbl.text = (Utility().formatDate(dateString:res.startDate ?? "") ?? "") + "-" + (Utility().formatDate(dateString:res.endDate ?? "") ?? "")
                self.offerstillAvailableLbl.text = "\(res.usageAvailable ?? 0)"
                self.termsLbl.text = res.terms
                self.Mid = res.merchant?.key ?? ""
                self.marchentApi(Key: res.merchant?.key ?? "", token: AppDefault.accessToken)
            case .failure(let error):
                Utility.showWarningAlert(message:"\(error)")
            }
        }
    }

    func marchentApi(Key:String,token:String) {
        APIManager.shared.Marchent(Key: Key, token: token){ result in
            switch result {
            case .success(let res):
                self.isLinked = res.isLinked ?? false
                if res.isLinked == true {
                    self.removeFromWorldBtnLbl.text = "Remove From My World"
                }else{
                    self.removeFromWorldBtnLbl.text = "Add To My World"
                }
            case .failure(let error):
                Utility.showWarningAlert(message:"\(error)")
            }
        }
    }
    
    func redeemApi(Key:String,token:String) {
        APIManager.shared.redeem(Key: Key, token: token){ result in
            switch result {
            case .success(let res):
                print(res)
            case .failure(let error):
                Utility.showWarningAlert(message:"\(error)")
            }
        }
    }
    
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
    
    
}
