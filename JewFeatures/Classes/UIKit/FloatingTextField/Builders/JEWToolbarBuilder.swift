//
//  JEWToolbarBuilder.swift
//  JewFeatures
//
//  Created by Joao Gabriel Medeiros Perei on 23/11/19.
//

import Foundation
public class JEWToolbarBuilder: NSObject, JEWToolbarBuilderProtocol {
    
    private var floatingTextField: JEWFloatingTextField?
    private var leftButtons: [JEWKeyboardToolbarButton] = [.cancel]
    private var rightButtons: [JEWKeyboardToolbarButton] = [.ok]
    private var shouldShowKeyboard: Bool = true
    public init(with floatingTextField: JEWFloatingTextField) {
        self.floatingTextField = floatingTextField
        super.init()
    }
    
    public override init() {
        
    }
    
    @discardableResult public func setToolbar(leftButtons: [JEWKeyboardToolbarButton] = [.cancel], rightButtons: [JEWKeyboardToolbarButton] = [.ok], shouldShowKeyboard: Bool = true) -> JEWToolbarBuilder {
        self.leftButtons = leftButtons
        self.rightButtons = rightButtons
        self.shouldShowKeyboard = shouldShowKeyboard
        return self
    }
    
    public func setup() {
        setToolbar()
    }
    
    private func setToolbar() {
        let toolbar = JEWKeyboardToolbar()
        toolbar.toolBarDelegate = floatingTextField
        toolbar.setup(leftButtons: leftButtons, rightButtons: rightButtons)
        if shouldShowKeyboard {
            floatingTextField?.textField.inputAccessoryView = toolbar
        } else {
            floatingTextField?.textField.inputView = UIView()
        }
    }
    
    public func setToolbar(in textView: JEWTextView) {
        let toolbar = JEWKeyboardToolbar()
        toolbar.toolBarDelegate = textView
        toolbar.setup(leftButtons: leftButtons, rightButtons: rightButtons)
        textView.textView.inputAccessoryView = toolbar
    }
    

}

