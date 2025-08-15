//
//  FilterViewController.swift
//  World2one
//
//  Created by Moin on 04/02/2025.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var browseFilterTblV: UITableView!
    @IBOutlet weak var browseGroupTblV: UITableView!

    var onDismiss: (() -> Void)?

    
    var filterArray: [FilterDataModel] = []
    var groupsArray: [FilterDataModel] = []
    
    
    var selectedIndex: Int?
    
    var selectedrowFilter = [IndexPath]()


    override func viewDidLoad() {
        super.viewDidLoad()
        filterMenuApi(token: AppDefault.accessToken)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        onDismiss?()
    }
    

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tableView == browseGroupTblV) ? groupsArray.count : filterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == browseFilterTblV {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as! FilterTableViewCell
            
            let data =  filterArray[indexPath.row]
            cell.titleLbl.text = data.title

            
            if AppDefault.filterArray2.contains(where: { $0.title == data.title }) == true {
                cell.checkBtn.setBackgroundImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            } else {
                cell.checkBtn.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
            }
            
            
            return cell
            
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as! FilterTableViewCell
            
            let data = groupsArray[indexPath.row]
            
            cell.titleLbl.text = data.title
            
            if let _ = AppDefault.filterArray2.firstIndex(where: { $0.title == data.title }) {
                cell.checkBtn.setBackgroundImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            } else {
                cell.checkBtn.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
            }
            
            cell.deleteBtn.tag = indexPath.row
            cell.deleteBtn.addTarget(self, action: #selector(deleteBtnTapped(_:)), for: .touchUpInside)

            return cell
        }
    }
    
    @objc func deleteBtnTapped(_ sender: UIButton) {
        let data = groupsArray[sender.tag]
        groupRemoveApi(id: data.value ?? "" , token: AppDefault.accessToken)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row  // Update selected index
                
        if tableView == browseGroupTblV {
            let data = groupsArray[indexPath.row]
            
            if let index = AppDefault.filterArray2.firstIndex(where: { $0.value == data.value }) {
                AppDefault.filterArray2.remove(at: index)
                AppDefault.groupId.removeAll(where: { $0 == data.value })
            } else {
                AppDefault.filterArray2.append(data)
                AppDefault.groupId.append(data.value ?? "")
            }
        } else {
            let data = filterArray[indexPath.row]
            
            if let index = AppDefault.filterArray2.firstIndex(where: { $0.title == data.title }) {
                AppDefault.filterArray2.remove(at: index)
                AppDefault.filterId.removeAll(where: { $0 == data.value })

            } else {
                AppDefault.filterArray2.append(data)
                AppDefault.filterId.append(data.value ?? "")
            }
        }
        
        
        browseGroupTblV.reloadData()
        browseFilterTblV.reloadData()

    }
}

// MARK: - API Call
extension FilterViewController {
    
    func filterMenuApi(token: String) {
        APIManager.shared.FilterMenu(token: token) { result in
            switch result {
            case .success(let res):
                if let browseGroupsIndex = res.firstIndex(where: {
                    $0.title?.trimmingCharacters(in: .whitespacesAndNewlines).caseInsensitiveCompare("BROWSE GROUPS") == .orderedSame
                }) {
                    self.filterArray = Array(res[1..<browseGroupsIndex])
                    self.groupsArray = Array(res[(browseGroupsIndex + 1)...])
                } else {
                    self.filterArray = res.count > 1 ? Array(res[1...]) : []
                    self.groupsArray = []
                }
                
                self.browseFilterTblV.reloadData()
                self.browseGroupTblV.reloadData()
                
            case .failure(let error):
                Utility.showWarningAlert(message: "\(error)")
            }
        }
    }
    
    func groupRemoveApi(id:String,token: String) {
        APIManager.shared.GroupRemove(id: id, token: token) { result in
            switch result {
            case .success(let res):
                if res.result == true {
                    Utility.showWarningAlert(message: "Group Successfully Deleted")
                }
                self.browseGroupTblV.reloadData()
            case .failure(let error):
                Utility.showWarningAlert(message: "\(error)")
            }
        }
    }
}
