//
//  JEWFloatingTextField.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 19/10/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import UIKit

public protocol JEWFloatingTextFieldDelegate: class {
    func infoButtonAction(_ textField: JEWFloatingTextField)
    func toolbarAction(_ textField: JEWFloatingTextField, typeOfAction type: JEWKeyboardToolbarButton)
    func textFieldDidBeginEditing(_ textField: JEWFloatingTextField)
    func textFieldDidEndEditing(_ textField: JEWFloatingTextField)
    func textFieldShouldChangeCharactersIn(_ textField: JEWFloatingTextField, text: String, isBackSpace: Bool)
}

public extension JEWFloatingTextFieldDelegate {
    func infoButtonAction(_ textField: JEWFloatingTextField) {}
    
    func toolbarAction(_ textField: JEWFloatingTextField, typeOfAction type: JEWKeyboardToolbarButton) {}
    
    func textFieldDidBeginEditing(_ textField: JEWFloatingTextField){}
    
    func textFieldDidEndEditing(_ textField: JEWFloatingTextField){}
}

public class JEWFloatingTextField: UIView {
   //Constants
    private static let animationDuration = 0.5
    private static let defaultHeight: CGFloat = 50
    private static let numberTwo: CGFloat = 2
    private static let minimumScale: CGFloat = 0.5
    private static let zero: CGFloat = 0
    
    //UI
    public let textField = UITextField(frame: .zero)
    let placeholderLabel = UILabel(frame: .zero)
    let bottomLineView = UIView(frame: .zero)
    var infoButton: UIButton? = nil
    
    //Variables
    public var delegate: JEWFloatingTextFieldDelegate?
    
    public var hasError: Bool = false {
        didSet {
            updateTextFieldUI()
        }
    }
    
    public var placeHolderText:String {
        return placeholderLabel.text ?? String()
    }
    
    public var textFieldText: String = String() {
        didSet {
            if textFieldText != String() {
                textField.text = textFieldText
                openKeyboard()
            }
        }
    }
    var selectedColor = UIColor.white {
        didSet {
            currentlySelectedColor = selectedColor
        }
    }
    
    var textFieldTextColor = UIColor.white {
        didSet {
            textField.textColor = textFieldTextColor
        }
    }
    
    var textFieldErrorColor = UIColor.red
    
    var hideBottomView: Bool = false
    
    var valueTypeTextField: JEWFloatingTextFieldValueType?
    var currentlySelectedColor = UIColor.white
    var placeholderColor: UIColor? {
        didSet {
            if let placeholderColor = self.placeholderColor {
                currentlyPlaceholderColor = placeholderColor
                return
            }
            currentlyPlaceholderColor = currentlySelectedColor
        }
    }
    var currentlyPlaceholderColor = UIColor.white
    var infoButtonColor = UIColor.white
    var smallFont = UIFont.systemFont(ofSize: 15)
    var bigFont = UIFont.systemFont(ofSize: 16)
    var bottomLabelConstraint = NSLayoutConstraint()
    var trailingLabelConstraint = NSLayoutConstraint()
    var trailingTextFieldConstraint = NSLayoutConstraint()
    var topTextFieldConstraint = NSLayoutConstraint()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setupView()
        textField.delegate = self
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        //setupView()
        textField.delegate = self
    }
    
    func updateTextFieldUI() {
        currentlySelectedColor = selectedColor
        placeholderLabel.textColor = currentlyPlaceholderColor
        textField.textColor = textFieldTextColor
        bottomLineView.backgroundColor = currentlyPlaceholderColor
        checkError()
    }
    
    func checkError() {
        if hasError {
            let errorColor = textFieldErrorColor
            placeholderLabel.textColor = errorColor
            textField.textColor = errorColor
            bottomLineView.backgroundColor = errorColor
        }
    }
}

extension JEWFloatingTextField: UITextFieldDelegate, JEWKeyboardToolbarDelegate {
    
   @objc func infoButtonTapped(_ sender: UIButton) {
        self.delegate?.infoButtonAction(self)
    }
    
    public func keyboardToolbar(button: UIBarButtonItem, type: JEWKeyboardToolbarButton, tappedIn toolbar: JEWKeyboardToolbar) {
        self.delegate?.toolbarAction(self, typeOfAction: type)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let isBackSpace = string == String()
        let fullText = String.init(format: "%@%@", textField.text ?? String(), string)
        textField.text = setFullText(text: fullText, isBackSpace: isBackSpace)
        delegate?.textFieldShouldChangeCharactersIn(self, text: textField.text ?? "", isBackSpace: isBackSpace)
        if isBackSpace {
            return true
        }
        return false
    }

    public func textFieldDidChangeSelection(_ textField: UITextField) {
        textFieldText = textField.text ?? String()
    }
    
    
    
    func setFullText(text: String, isBackSpace: Bool) -> String {
        guard let type = valueTypeTextField else {
            return text
        }
        return type.formatText(textFieldText: text, isBackSpace: isBackSpace)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldDidBeginEditing(self)
        openKeyboard()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldDidEndEditing(self)
        if textField.text == String() || textField.text == nil {
            closeKeyboard()
        }
    }
    
    func openKeyboard() {
        UIView.animate(withDuration: JEWFloatingTextField.animationDuration) { [weak self] in
            self?.bottomLabelConstraint.constant = -(self?.frame.height ?? JEWFloatingTextField.defaultHeight)/JEWFloatingTextField.numberTwo
            self?.topTextFieldConstraint.constant = (self?.frame.height ?? JEWFloatingTextField.defaultHeight)/JEWFloatingTextField.numberTwo
            self?.placeholderLabel.font = self?.smallFont
            self?.checkError()
            self?.layoutIfNeeded()
        }
    }
    
    public func clear() {
        self.textField.text = String()
        closeKeyboard()
    }
    
    func closeKeyboard() {
        UIView.animate(withDuration: JEWFloatingTextField.animationDuration/Double(JEWFloatingTextField.numberTwo)) { [weak self] in
            if self?.textField.text == "" || self?.textField.text == nil {
                self?.bottomLabelConstraint.constant = JEWFloatingTextField.zero
                self?.topTextFieldConstraint.constant = JEWFloatingTextField.zero
                self?.placeholderLabel.minimumScaleFactor = JEWFloatingTextField.minimumScale
                self?.placeholderLabel.font = self?.bigFont
                self?.checkError()
            }
            self?.endEditing(true)
            self?.layoutIfNeeded()
        }
    }
}


