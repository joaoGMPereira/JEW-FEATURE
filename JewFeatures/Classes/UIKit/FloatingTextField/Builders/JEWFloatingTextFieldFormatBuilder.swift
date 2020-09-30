//
//  JEWFloatingTextFieldDelegateBuilder.swift
//  JewFeatures
//
//  Created by Joao Gabriel Medeiros Perei on 23/11/19.
//

import Foundation

public class JEWFloatingTextFieldFormatBuilder: NSObject, JEWFloatingTextFieldBuilderProtocol {
    
    private var floatingTextField: JEWFloatingTextField = JEWFloatingTextField(frame: .zero)
    
    var placeholder = String()
    var placeholderColor = UIColor.JEWDefault()
    var selectedColor = UIColor.JEWDefault()
    var infoButtonColor = UIColor.JEWDefault()
    var textFieldTextColor = UIColor.black
    var smallFont = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
    var bigFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    var hideBottomView = false
    var keyboardType = UIKeyboardType.default
    var valueTypeTextField: JEWFloatingTextFieldValueType? = JEWFloatingTextFieldValueType.none
    var autocorrectionType = UITextAutocorrectionType.no
    var keyboardAppearance = UIKeyboardAppearance.default
    
    public init(with floatingTextField: JEWFloatingTextField) {
        self.floatingTextField = floatingTextField
        super.init()
    }
    
    public override init() {
        super.init()
    }
    
    public func setAll(withPlaceholder placeholder: String) -> JEWFloatingTextFieldFormatBuilder {
        return setPlaceholder(text: placeholder)
            .setPlaceholderColor()
            .setSelectedColor()
            .setTextFieldTextColor()
            .setInfoButtonColor()
            .setSmallFont()
            .setBigFont()
            .setKeyboardType()
            .setTextFieldValueType()
            .setTextFieldAutoCorrection()
            .setTextFieldKeyboardAppearance()
            .setHideBottomView()
    }
    
    public func setPlaceholder(text: String = String()) -> JEWFloatingTextFieldFormatBuilder {
        placeholder = text
        return self
    }
    
    public func setPlaceholderColor(color: UIColor = .white) -> JEWFloatingTextFieldFormatBuilder {
        placeholderColor = color
        return self
    }
    
    public func setSelectedColor(color: UIColor = .white) -> JEWFloatingTextFieldFormatBuilder {
        selectedColor = color
        return self
    }
    
    public func setInfoButtonColor(color: UIColor = .white) -> JEWFloatingTextFieldFormatBuilder {
        infoButtonColor = color
        return self
    }
    
    public func setTextFieldTextColor(color: UIColor = .white) -> JEWFloatingTextFieldFormatBuilder {
        textFieldTextColor = color
        return self
    }
    
    public func setSmallFont(font: UIFont = .JEW14()) -> JEWFloatingTextFieldFormatBuilder {
        smallFont = font
        return self
    }
    
    public func setBigFont(font: UIFont = .JEW16()) -> JEWFloatingTextFieldFormatBuilder {
        bigFont = font
        return self
    }
    
    public func setHideBottomView(isHidden: Bool = false) -> JEWFloatingTextFieldFormatBuilder {
        hideBottomView = isHidden
        return self
    }
    
    public func setKeyboardType(type: UIKeyboardType = .default) -> JEWFloatingTextFieldFormatBuilder {
        keyboardType = type
        return self
    }
    
    public func setTextFieldValueType(type: JEWFloatingTextFieldValueType? = nil) -> JEWFloatingTextFieldFormatBuilder {
        valueTypeTextField = type
        return self
    }
    
    public func setTextFieldAutoCorrection(isOn: UITextAutocorrectionType = .no) -> JEWFloatingTextFieldFormatBuilder {
        autocorrectionType = isOn
        return self
    }
    
    public func setTextFieldKeyboardAppearance(appearance: UIKeyboardAppearance = .default) -> JEWFloatingTextFieldFormatBuilder {
        keyboardAppearance = appearance
        return self
    }
    
    public func update(textField: JEWFloatingTextField) -> JEWFloatingTextFieldFormatBuilder  {
        self.floatingTextField = textField
        return self
    }
    
    public func setup() {
        
        self.floatingTextField.placeholderLabel.text = placeholder
        self.floatingTextField.placeholderColor = placeholderColor
        self.floatingTextField.selectedColor = selectedColor
        self.floatingTextField.infoButtonColor = infoButtonColor
        self.floatingTextField.textFieldTextColor = textFieldTextColor
        self.floatingTextField.smallFont = smallFont
        self.floatingTextField.bigFont = bigFont
        self.floatingTextField.hideBottomView = hideBottomView
        self.floatingTextField.textField.keyboardType = keyboardType
        self.floatingTextField.valueTypeTextField = valueTypeTextField
        self.floatingTextField.textField.autocorrectionType = autocorrectionType
        self.floatingTextField.textField.keyboardAppearance = keyboardAppearance
        
        if self.floatingTextField.textField.text != nil && self.floatingTextField.textField.text != String() {
            self.floatingTextField.openKeyboard()
        }
    }
    
}
