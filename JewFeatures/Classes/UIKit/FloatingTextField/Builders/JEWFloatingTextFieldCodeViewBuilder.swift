//
//  JEWFloatingTextFieldCodeViewBuilder.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 19/10/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import UIKit
class JEWFloatingTextFieldCodeViewBuilder: NSObject, JEWToolbarBuilderProtocol, JEWCodeView {
        private static let eightyPercentSize: CGFloat = 0.8
    private static let padding: CGFloat = 16
    
    private var floatingTextField: JEWFloatingTextField
    init(with floatingTextField: JEWFloatingTextField) {
        self.floatingTextField = floatingTextField
        super.init()
    }
    func setup() {
        self.setupView()
    }
    
    func buildViewHierarchy() {
        self.floatingTextField.addSubview(self.floatingTextField.textField)
        self.floatingTextField.addSubview(self.floatingTextField.placeholderLabel)
        self.floatingTextField.addSubview(self.floatingTextField.bottomLineView)
        self.floatingTextField.textField.translatesAutoresizingMaskIntoConstraints = false
        self.floatingTextField.placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        self.floatingTextField.bottomLineView.translatesAutoresizingMaskIntoConstraints = false
        self.floatingTextField.placeholderLabel.isUserInteractionEnabled = false
    }
    
    func setupConstraints() {
        let trailingFromInfoButton: CGFloat = -8
        self.floatingTextField.trailingLabelConstraint = self.floatingTextField.placeholderLabel.trailingAnchor.constraint(equalTo: self.floatingTextField.trailingAnchor, constant: trailingFromInfoButton)
        self.floatingTextField.bottomLabelConstraint = self.floatingTextField.placeholderLabel.bottomAnchor.constraint(equalTo: self.floatingTextField.bottomLineView.topAnchor)
        self.floatingTextField.trailingTextFieldConstraint = self.floatingTextField.textField.trailingAnchor.constraint(equalTo: self.floatingTextField.trailingAnchor, constant: trailingFromInfoButton)
        self.floatingTextField.topTextFieldConstraint = self.floatingTextField.textField.topAnchor.constraint(equalTo: self.floatingTextField.topAnchor)

        NSLayoutConstraint.activate([
            self.floatingTextField.placeholderLabel.leadingAnchor.constraint(equalTo: self.floatingTextField.leadingAnchor, constant: 8),
            self.floatingTextField.trailingLabelConstraint,
            self.floatingTextField.placeholderLabel.topAnchor.constraint(equalTo: self.floatingTextField.topAnchor),
            self.floatingTextField.bottomLabelConstraint
            ])
        NSLayoutConstraint.activate([
            self.floatingTextField.textField.leadingAnchor.constraint(equalTo: self.floatingTextField.leadingAnchor, constant: 8),
            self.floatingTextField.trailingTextFieldConstraint,
            self.floatingTextField.topTextFieldConstraint,
            self.floatingTextField.textField.bottomAnchor.constraint(equalTo: self.floatingTextField.bottomLineView.topAnchor, constant: 1)
            ])
        
        NSLayoutConstraint.activate([
            self.floatingTextField.bottomLineView.leadingAnchor.constraint(equalTo: self.floatingTextField.leadingAnchor),
            self.floatingTextField.bottomLineView.trailingAnchor.constraint(equalTo: self.floatingTextField.trailingAnchor),
            self.floatingTextField.bottomLineView.heightAnchor.constraint(equalToConstant: 1),
            self.floatingTextField.bottomLineView.bottomAnchor.constraint(equalTo: self.floatingTextField.bottomAnchor)
            ])
    }
    
    func setupAdditionalConfiguration() {
        self.floatingTextField.placeholderLabel.adjustsFontSizeToFitWidth = true
        self.floatingTextField.placeholderLabel.minimumScaleFactor = 0.5
        self.floatingTextField.placeholderLabel.font = self.floatingTextField.bigFont
        self.floatingTextField.placeholderLabel.textColor = self.floatingTextField.currentlyPlaceholderColor
        self.floatingTextField.bottomLineView.backgroundColor = self.floatingTextField.currentlySelectedColor
        self.floatingTextField.bottomLineView.isHidden = self.floatingTextField.hideBottomView
    }
}
