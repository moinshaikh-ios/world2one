//
//  File.swift
//  World2one
//
//  Created by Moin on 28/01/2025.
//

import Foundation
import UIKit

enum Boards: String {
    case main = "Main"
    case auth = "Auth"
    case onboard = "OnBoarding"
    case dashboard = "Dashboard"
    case home = "Home"
    
    var stortBoard: UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: Bundle.main)
    }
}

extension NSObject {
    class var identifierr: String {
        return String(describing: self)
    }
}

extension UIViewController {
    
    static func getVC(_ storyBoard: Boards) -> Self {
        
        func instanceFromNib<T: UIViewController>(_ storyBoard: Boards) -> T {
            guard let vc = controller(storyBoard: storyBoard, controller: T.identifierr) as? T else {
                fatalError("'\(storyBoard.rawValue)' : '\(T.identifierr)' is Not exist")
            }
            return vc
        }
        return instanceFromNib(storyBoard)
    }
    
    
    static func controller(storyBoard: Boards, controller: String) -> UIViewController {
        let storyBoard = storyBoard.stortBoard
        let vc = storyBoard.instantiateViewController(withIdentifier: controller)
        return vc
    }
    
    func delay(seconds: Double, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }

    func presentViewController(after delay: Double, from viewController: UIViewController, to presentVC: UIViewController) {
        self.delay(seconds: delay) {
            let navigationController = UINavigationController(rootViewController: presentVC)
                navigationController.modalPresentationStyle = .fullScreen
               viewController.present(navigationController, animated: true, completion: nil)
        }
    }
    
    
    func popViewController(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
}

func getCurrentViewController() -> UIViewController? {
    var topController = UIApplication.shared.keyWindow?.rootViewController
    
    while let presentedViewController = topController?.presentedViewController {
        topController = presentedViewController
    }
    
    if let navigationController = topController as? UINavigationController {
        topController = navigationController.topViewController
    }
    
    return topController
}

protocol DropdownViewDelegate: AnyObject {
    func didSelectItem(title: String)
}

class DropdownView: UIView, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: DropdownViewDelegate?

    private var menuItems: [(title: String, icon: String)] {
        if AppDefault.accessToken.isEmpty {
            return [
//                ("None", "profile"),
                ("Register Now", "registernow"),
                ("How it Works", "howitworks"),
                ("Terms of Service", "termsandcondition"),
                ("Privacy Policy", "privacypolicy"),
//                ("Logout", "logout")
            ]
        } else {
            return [
                (AppDefault.username, "profile"),
                ("How it Works", "howitworks"),
                ("Terms of Service", "termsandcondition"),
                ("Privacy Policy", "privacypolicy"),
                ("Logout", "logout")
            ]
        }
    }
    
    private let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
        self.isHidden = true // Initially hidden

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        addSubview(tableView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = self.bounds
    }

    func showDropdown(below button: UIButton, in view: UIView) {
        guard let superview = button.superview else { return }
        
        let buttonFrame = superview.convert(button.frame, to: view)
        let dropdownWidth: CGFloat = 300  // Fixed width
        let dropdownHeight = CGFloat(menuItems.count * 60)

        // Positioning: Trailing aligned to button, ensuring it doesn't go out of screen
        let maxX = buttonFrame.maxX
        let minX = max(buttonFrame.maxX - dropdownWidth, 10) // Ensure it doesn't exceed left boundary

        self.frame = CGRect(x: minX, y: buttonFrame.maxY + 5, width: dropdownWidth, height: 0)
        view.addSubview(self)

        UIView.animate(withDuration: 0.3) {
            self.frame.size.height = dropdownHeight
            self.isHidden = false
        }
    }

    func hideDropdown() {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.size.height = 0
        }) { _ in
            self.isHidden = true
            self.removeFromSuperview()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = menuItems[indexPath.row]
        cell.imageView?.image = UIImage(named: item.icon) // Use system icon
        cell.textLabel?.text = item.title
        cell.selectionStyle = .none
        if item.title == "Logout" {
            cell.textLabel?.textColor = UIColor(hex: "#F58B6F")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectItem(title: selectedItem.title)
        hideDropdown()
    }
}
