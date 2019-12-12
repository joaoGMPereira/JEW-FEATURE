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
}

public extension JEWFloatingTextFieldDelegate {
    func infoButtonAction(_ textField: JEWFloatingTextField) {}
    
    func toolbarAction(_ textField: JEWFloatingTextField, typeOfAction type: JEWKeyboardToolbarButton) {}
    
    func textFieldDidBeginEditing(_ textField: JEWFloatingTextField){}
    
    func textFieldDidEndEditing(_ textField: JEWFloatingTextField){}
}

public class JEWFloatingTextField: UIView {
    
    //Constants
    static let requiredCharacter: String = "*"
    private static let animationDuration = 0.5
    private static let defaultHeight: CGFloat = 50
    private static let numberTwo: CGFloat = 2
    private static let eightyPercentSize: CGFloat = 0.8
    private static let padding: CGFloat = 16
    private static let minimumScale: CGFloat = 0.5
    private static let zero: CGFloat = 0
    
    //UI
    let textField = UITextField(frame: .zero)
    let placeholderLabel = UILabel(frame: .zero)
    let bottomLineView = UIView(frame: .zero)
    let infoButton = UIButton.init(type: .infoLight)
    
    //Variables
    var delegate: JEWFloatingTextFieldDelegate?
    
    var typeTextField: JEWFloatingTextFieldType?
    var required: Bool = false
    
    var hasError: Bool = false {
        didSet {
            updateTextFieldUI()
        }
    }
    
    var textFieldText: String = String() {
        didSet {
            if textFieldText != String() {
                textField.text = textFieldText
                openKeyboard()
            }
        }
    }
    var selectedColor = UIColor.lightGray {
        didSet {
            currentlySelectedColor = selectedColor
        }
    }
    
    var textFieldTextColor = UIColor.JEWBlack() {
        didSet {
            textField.textColor = textFieldTextColor
        }
    }
    
    var valueTypeTextField: JEWFloatingTextFieldValueType?
    var currentlySelectedColor = UIColor.lightGray
    var smallFont = UIFont.systemFont(ofSize: 11)
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
        placeholderLabel.text = placeholderLabel.text?.replacingOccurrences(of: JEWFloatingTextField.requiredCharacter, with: String())
        if hasError {
            currentlySelectedColor = .JEWRed()
            placeholderLabel.text = "\(placeholderLabel.text ?? String())\(JEWFloatingTextField.requiredCharacter)"
        }
        placeholderLabel.textColor = currentlySelectedColor
        bottomLineView.backgroundColor = currentlySelectedColor
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
        
        if isBackSpace {
            return true
        }
        textFieldText = textField.text ?? String()
        return false
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
            self?.placeholderLabel.textColor = self?.currentlySelectedColor
            self?.bottomLineView.backgroundColor = self?.currentlySelectedColor
            self?.layoutIfNeeded()
        }
    }
    
    func clear() {
        self.textField.text = String()
        closeKeyboard()
    }
    
    func closeKeyboard() {
        let trailingFromInfoButton = -((frame.height * JEWFloatingTextField.eightyPercentSize) + JEWFloatingTextField.padding)
        UIView.animate(withDuration: JEWFloatingTextField.animationDuration/Double(JEWFloatingTextField.numberTwo)) { [weak self] in
            if self?.textField.text == "" || self?.textField.text == nil {
                self?.trailingLabelConstraint.constant = trailingFromInfoButton
                self?.bottomLabelConstraint.constant = JEWFloatingTextField.zero
                self?.topTextFieldConstraint.constant = JEWFloatingTextField.zero
                self?.placeholderLabel.minimumScaleFactor = JEWFloatingTextField.minimumScale
                self?.placeholderLabel.font = self?.bigFont
                self?.placeholderLabel.textColor = .lightGray
                self?.bottomLineView.backgroundColor = UIColor.lightGray
            }
            self?.endEditing(true)
            self?.layoutIfNeeded()
        }
    }
}


