//
//  KeyboardService.swift
//  JewFeatures
//
//  Created by Joao Gabriel Medeiros Perei on 10/12/19.
//

import Foundation
import UIKit

public protocol KeyboardDelegate : class {
    func keyboardChanged(keyboard: Keyboard, state: Keyboard.State)
}

public class Keyboard {
    public enum State {
        case visible(size: CGSize)
        case hidden
    }
    private var hasToolbar: Bool = false
    private weak var delegate: KeyboardDelegate?
    public var keyboardChanged: ((_ state: Keyboard.State) -> Void)?
    
    public init() {}
    
    public func register(target: KeyboardDelegate? = nil, keyboardChanged: ((_ state: Keyboard.State) -> Void)? = nil, hasToolbar: Bool = false) {
        self.delegate = target
        self.keyboardChanged = keyboardChanged
        self.hasToolbar = hasToolbar
        
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    public func unregister() {
        self.delegate = nil
        self.keyboardChanged = nil
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc public func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardFrame: CGRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let toolbarHeight: CGFloat = hasToolbar ? 44 : 0
        let updatedSize = CGSize.init(width: keyboardFrame.width, height: keyboardFrame.height + toolbarHeight)
        let state: Keyboard.State = Keyboard.State.visible(size: updatedSize)
        
        // delegate
        self.delegate?.keyboardChanged(keyboard: self, state: state)
        
        // closure notification
        self.keyboardChanged?(state)
    }
    
    @objc public func keyboardWillHide(_ notification: NSNotification) {
        let state: Keyboard.State = Keyboard.State.hidden
        
        // delegate
        self.delegate?.keyboardChanged(keyboard: self, state: Keyboard.State.hidden)
        
        // closure notification
        self.keyboardChanged?(state)
    }
}
