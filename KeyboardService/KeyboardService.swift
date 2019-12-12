//
//  KeyboardService.swift
//  JewFeatures
//
//  Created by Joao Gabriel Medeiros Perei on 10/12/19.
//

import Foundation
import UIKit

public class KeyboardService: NSObject {
    public static var serviceSingleton = KeyboardService()
    var measuredSize: CGRect = CGRect.zero
    
    @objc public class func keyboardHeight() -> CGFloat {
        let keyboardSize = KeyboardService.keyboardSize()
        return keyboardSize.size.height
    }
    
    @objc public class func keyboardSize() -> CGRect {
        return serviceSingleton.measuredSize
    }
    
    private func observeKeyboardNotifications() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(self.keyboardChange), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    private func observeKeyboard() {
        let field = UITextField()
        UIApplication.shared.windows.first?.addSubview(field)
        field.becomeFirstResponder()
        field.resignFirstResponder()
        field.removeFromSuperview()
    }
    
    @objc private func keyboardChange(_ notification: Notification) {
        guard measuredSize == CGRect.zero, let info = notification.userInfo,
            let value = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else { return }
        
        measuredSize = value.cgRectValue
    }
    
    override init() {
        super.init()
        observeKeyboardNotifications()
        observeKeyboard()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
