//
//  JEWFloatingTextFieldToolbarBuilder.swift
//  JewFeatures
//
//  Created by Joao Gabriel Medeiros Perei on 23/11/19.
//

import Foundation
public class JEWFloatingTextFieldToolbarBuilder: NSObject, JEWFloatingTextFieldBuilderProtocol {
    
    private var floatingTextField: JEWFloatingTextField
    private var leftButtons: [JEWKeyboardToolbarButton] = [.cancel]
    private var rightButtons: [JEWKeyboardToolbarButton] = [.ok]
    private var shouldShowKeyboard: Bool = true
    public init(with floatingTextField: JEWFloatingTextField) {
        self.floatingTextField = floatingTextField
        super.init()
    }
    
    public func setToolbar(leftButtons: [JEWKeyboardToolbarButton] = [.cancel], rightButtons: [JEWKeyboardToolbarButton] = [.ok], shouldShowKeyboard: Bool = true) -> JEWFloatingTextFieldToolbarBuilder {
        self.leftButtons = leftButtons
        self.rightButtons = rightButtons
        self.shouldShowKeyboard = shouldShowKeyboard
        return self
    }
    
    public func setup() {
        setToolbar()
    }
    
    func setToolbar() {
        let toolbar = JEWKeyboardToolbar()
        toolbar.toolBarDelegate = floatingTextField
        toolbar.setup(leftButtons: leftButtons, rightButtons: rightButtons)
        if shouldShowKeyboard {
            floatingTextField.floatingTextField.inputAccessoryView = toolbar
        } else {
            floatingTextField.floatingTextField.inputView = UIView()
        }
    }
    

}

