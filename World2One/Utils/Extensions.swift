//
//  Extensions.swift
//  World2one
//
//  Created by Moin on 28/01/2025.
//

import Foundation
import UIKit
import ObjectiveC
import Kingfisher


@IBDesignable
extension UIScrollView {

    @IBInspectable override var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable override var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }

    @IBInspectable override var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable override var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
            self.layer.shadowOpacity = newValue > 0 ? 0.5 : 0  // Default shadow opacity
            self.layer.shadowOffset = CGSize(width: 0, height: 2)  // Default shadow offset
        }
    }
}


@IBDesignable
extension UIView {

    // MARK: - Corner Radius
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0  // Ensure content is clipped to the corners
        }
    }

    // MARK: - Border
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }

    // MARK: - Shadow
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
            self.layer.shadowOpacity = newValue > 0 ? 0.5 : 0  // Default shadow opacity
            self.layer.shadowOffset = CGSize(width: 0, height: 2)  // Default shadow offset
        }
    }

    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor ?? UIColor.clear.cgColor)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }

    @IBInspectable var shadowOffsetX: CGFloat {
        get {
            return self.layer.shadowOffset.width
        }
        set {
            self.layer.shadowOffset.width = newValue
        }
    }

    @IBInspectable var shadowOffsetY: CGFloat {
        get {
            return self.layer.shadowOffset.height
        }
        set {
            self.layer.shadowOffset.height = newValue
        }
    }

    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
}


@IBDesignable
extension UIButton {

    // MARK: - Corner Radius
    @IBInspectable override var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0  // Ensure content is clipped to the corners
        }
    }

    // MARK: - Border
    @IBInspectable override var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }

    @IBInspectable override var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }

    // MARK: - Shadow
    @IBInspectable override var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
            self.layer.shadowOpacity = newValue > 0 ? 0.5 : 0  // Default shadow opacity
            self.layer.shadowOffset = CGSize(width: 0, height: 2)  // Default shadow offset
        }
    }

    @IBInspectable override var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor ?? UIColor.clear.cgColor)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }

    @IBInspectable override var shadowOffsetX: CGFloat {
        get {
            return self.layer.shadowOffset.width
        }
        set {
            self.layer.shadowOffset.width = newValue
        }
    }

    @IBInspectable override var shadowOffsetY: CGFloat {
        get {
            return self.layer.shadowOffset.height
        }
        set {
            self.layer.shadowOffset.height = newValue
        }
    }

    @IBInspectable override var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
}

@IBDesignable
extension UIStackView {

    // MARK: - Corner Radius
    @IBInspectable override var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0  // Ensure content is clipped to the corners
        }
    }

    // MARK: - Border
    @IBInspectable override var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }

    @IBInspectable override var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }

    // MARK: - Shadow
    @IBInspectable override var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
            self.layer.shadowOpacity = newValue > 0 ? 0.5 : 0  // Default shadow opacity
            self.layer.shadowOffset = CGSize(width: 0, height: 2)  // Default shadow offset
        }
    }

    @IBInspectable override var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor ?? UIColor.clear.cgColor)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }

    @IBInspectable override var shadowOffsetX: CGFloat {
        get {
            return self.layer.shadowOffset.width
        }
        set {
            self.layer.shadowOffset.width = newValue
        }
    }

    @IBInspectable override var shadowOffsetY: CGFloat {
        get {
            return self.layer.shadowOffset.height
        }
        set {
            self.layer.shadowOffset.height = newValue
        }
    }

    @IBInspectable override var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        // Remove the '#' character if it's present
        var hexColor = hex
        if hex.hasPrefix("#") {
            hexColor = String(hex.dropFirst())
        }
        
        // Handle 6-digit hex (RGB) and 8-digit hex (RGBA)
        if hexColor.count == 6 || hexColor.count == 8 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                if hexColor.count == 6 {
                    r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000FF) / 255
                    a = 1.0 // Default alpha to 1 (opaque) for 6-digit hex
                } else {
                    r = CGFloat((hexNumber & 0xFF000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000FF) / 255
                }
                
                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        }
        
        return nil
    }
}

extension UITextField {
    func enablePasswordToggle() {
        // Create the toggle button for showing/hiding password
        let toggleButton = UIButton(type: .custom)
        toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        toggleButton.setImage(UIImage(systemName: "eye"), for: .selected)
        toggleButton.tintColor = .gray  // Initial color set to gray
        
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        toggleButton.isHidden = true

        self.rightView = toggleButton
        self.rightViewMode = .always
        self.isSecureTextEntry = true
        // Add observer to listen for text changes
        self.addTarget(self, action: #selector(TextFieldDidChange), for: .editingChanged)
        
        // Store the reference of toggleButton as an associated object to change its color
        objc_setAssociatedObject(self, &toggleButtonKey, toggleButton, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    @objc func TextFieldDidChange() {
        // Retrieve the toggleButton associated with this text field
        guard let toggleButton = objc_getAssociatedObject(self, &toggleButtonKey) as? UIButton else { return }
        
        // Change the color based on the text length
        if self.text?.count ?? 0 > 0 {
            toggleButton.tintColor = UIColor(named: "primaryColor")
            toggleButton.isHidden = false
        } else {
            toggleButton.tintColor = .gray
            toggleButton.isHidden = true
        }
    }
    
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        // Toggle the password visibility
        sender.isSelected.toggle()
        self.isSecureTextEntry.toggle()
    }
}

// You can define a unique key for associated objects
private var toggleButtonKey: UInt8 = 0

extension UIButton {
    func enableCheckToggle() {
        self.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        self.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        self.tintColor = UIColor(named: "primaryColor")
        self.addTarget(self, action: #selector(toggleCheckUncheck), for: .touchUpInside)

    }
    
    @objc private func toggleCheckUncheck(_ sender: UIButton) {
        // Toggle the password visibility
        sender.isSelected.toggle()
    }
    

}

extension UITextView {
    
    /// Method to set attributed text and make specific words clickable
    /// - Parameters:
    ///   - text: The full text to be set on the UITextView.
    ///   - linkText1: The first word to be made clickable (link).
    ///   - linkURL1: The URL for the first clickable word.
    ///   - linkText2: The second word to be made clickable (optional).
    ///   - linkURL2: The URL for the second clickable word (optional).
    ///   - fontName: The font name to apply (e.g., "Poppins-Regular").
    ///   - fontSize: The font size to apply.
    ///   - textColor: The color of the text.
    ///   - lineSpacing: The line spacing to apply (default is 0).
    ///   - alignment: The alignment for the text (default is .left).
    func setAttributedTextWithLinks(
        text: String,
        linkText1: String?,
        linkURL1: String?,
        linkText2: String? = nil,
        linkURL2: String? = nil,
        fontName: String = "System", // Default to system font if no name is provided
        fontSize: CGFloat = 14,
        textColor: UIColor = .black,
        lineSpacing: CGFloat = 0,
        alignment: NSTextAlignment = .left
    ) {
        
        // Create an NSMutableAttributedString to hold the final text
        let attributedString = NSMutableAttributedString(string: text)
        
        // Create paragraph style for line spacing and alignment
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment
        
        // Set the default attributes for the entire text (font, color, paragraph style)
        let defaultAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: fontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize),
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle
        ]
        
        // Apply the default attributes to the whole text
        attributedString.addAttributes(defaultAttributes, range: NSRange(location: 0, length: text.count))
        
        // Make linkText1 clickable
        if let linkText1 = linkText1, let linkURL1 = linkURL1 {
            let range1 = (text as NSString).range(of: linkText1)
            attributedString.addAttribute(.link, value: linkURL1, range: range1)
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
        }
        
        // Make linkText2 clickable (optional)
        if let linkText2 = linkText2, let linkURL2 = linkURL2 {
            let range2 = (text as NSString).range(of: linkText2)
            attributedString.addAttribute(.link, value: linkURL2, range: range2)
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range2)
        }
        
        // Set the final attributed text to the UITextView
        self.attributedText = attributedString
        
        // Enable user interaction on the text view
        self.isUserInteractionEnabled = true
        self.delegate = self // Optional: You can implement link handling in the delegate.
    }
}


// Conform to UITextViewDelegate to handle link taps
extension UITextView: UITextViewDelegate {
    
    // Handle tap on links in the text view
    public func textView(_ textView: UITextView, shouldInteractWith url: URL, in characterRange: NSRange) -> Bool {
        if url.absoluteString == "terms" {
            if let url = URL(string: "https://www.world2one.com/terms/") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else if url.absoluteString == "privacy" {
            if let url = URL(string: "https://www.world2one.com/privacy/") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }else if url.absoluteString == "register" {
            let vc = RegisterViewController.getVC(.auth)
              vc.isComeFrom = "login"
            getCurrentViewController()?.navigationController?.pushViewController(vc, animated: true)
        }else if url.absoluteString == "login" {
            getCurrentViewController()?.popViewController(animated: true)
        }else if url.absoluteString == "choose" {
            let vc = LoginViewController.getVC(.auth)
            getCurrentViewController()?.navigationController?.pushViewController(vc, animated: true)
        }
        return false
    }
}


private var floatingLabelKey: UInt8 = 0
private var containerViewKey: UInt8 = 0

extension UITextField {
    
    // Floating label property
    var floatingLabel: UILabel? {
        get {
            return objc_getAssociatedObject(self, &floatingLabelKey) as? UILabel
        }
        set {
            objc_setAssociatedObject(self, &floatingLabelKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // Container view property
    var containerView: UIView? {
        get {
            return objc_getAssociatedObject(self, &containerViewKey) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &containerViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // Method to add floating label and container view
    func setupFloatingLabel(containerView: UIView, floatingLabel: UILabel) {
        self.containerView = containerView
        self.floatingLabel = floatingLabel
        
     
        
     
        
        // Set up the target for text field editing changes
        self.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        guard let containerView = self.containerView, let floatingLabel = self.floatingLabel else { return }
        
        if self.text?.count ?? 0 > 0 {
                UIView.animate(withDuration: 0.3, animations: {
                    floatingLabel.alpha = 1.0
                    floatingLabel.textColor = UIColor(named: "primaryColor")
                    containerView.borderColor = UIColor(named: "primaryColor")
                    floatingLabel.frame.origin = CGPoint(x: containerView.bounds.origin.x + 45, y: containerView.bounds.origin.y - 3)
                })
        }else {
                UIView.animate(withDuration: 0.3, animations: {
                    floatingLabel.alpha = 0.5
                    floatingLabel.textColor = .gray
                    containerView.borderColor = .gray
                    floatingLabel.frame.origin = CGPoint(x: self.bounds.origin.x + 85, y: self.bounds.origin.y + 25)
            })
        }

    }
}



extension UIImageView{
    func pLoadImage(url:String) {
        if let http = URL(string: url) {
            var comps = URLComponents(url: http, resolvingAgainstBaseURL: false)!
            comps.scheme = "https"
            let https = comps.url!
            print(https)
            self.kf.indicatorType = .none
            self.kf.setImage(with: http,placeholder: #imageLiteral(resourceName: "placeHolder"))
        }else{
            self.image = #imageLiteral(resourceName: "placeHolder")
        }

    }
    func pLoadImage2(url:String) {
        if let http = URL(string: url) {
            var comps = URLComponents(url: http, resolvingAgainstBaseURL: false)!
            comps.scheme = "https"
            let https = comps.url!
            print(https)
            self.kf.indicatorType = .activity
            self.kf.setImage(with: http,placeholder: #imageLiteral(resourceName: "placeHolder"))
        }else{
            self.image = #imageLiteral(resourceName: "placeHolder")
        }

    }
    func pLoadImage3(url:String) {
        if let http = URL(string: url) {
            var comps = URLComponents(url: http, resolvingAgainstBaseURL: false)!
            comps.scheme = "https"
            let https = comps.url!
            print(https)
            self.kf.indicatorType = .activity
            self.kf.setImage(with: http,placeholder: #imageLiteral(resourceName: "placeHolder2"))
        }else{
            self.image = #imageLiteral(resourceName: "placeHolder2")
        }

    }
    func pLoadImage4(url:String) {
        if let http = URL(string: url) {
            var comps = URLComponents(url: http, resolvingAgainstBaseURL: false)!
            comps.scheme = "https"
            let https = comps.url!
            print(https)

            self.kf.setImage(with: http)

        }else{

        }

    }



}
