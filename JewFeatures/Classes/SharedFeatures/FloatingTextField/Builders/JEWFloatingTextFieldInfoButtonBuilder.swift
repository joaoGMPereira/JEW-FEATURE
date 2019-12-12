//
//  JEWFloatingTextFieldInfoButtonBuilder.swift
//  JewFeatures
//
//  Created by Joao Gabriel Medeiros Perei on 23/11/19.
//

import Foundation

class JEWFloatingTextFieldInfoButtonBuilder: NSObject, JEWFloatingTextFieldBuilderProtocol {
    
    private var floatingTextField: JEWFloatingTextField
    init(with floatingTextField: JEWFloatingTextField) {
        self.floatingTextField = floatingTextField
        super.init()
    }
    func setup() {
        updateInfoButton()
    }
    
    func updateInfoButton() {
        floatingTextField.addSubview(floatingTextField.infoButton)
        floatingTextField.infoButton.translatesAutoresizingMaskIntoConstraints = false
        floatingTextField.infoButton.tintColor = .JEWDefault()
        floatingTextField.infoButton.addTarget(self, action: #selector(JEWFloatingTextField.infoButtonTapped(_:)), for: .touchUpInside)
        let size = floatingTextField.frame.height * 0.8
        NSLayoutConstraint.activate([
            floatingTextField.infoButton.trailingAnchor.constraint(equalTo: floatingTextField.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            floatingTextField.infoButton.heightAnchor.constraint(equalToConstant: size),
            floatingTextField.infoButton.widthAnchor.constraint(equalToConstant: size),
            floatingTextField.infoButton.centerYAnchor.constraint(equalTo: floatingTextField.safeAreaLayoutGuide.centerYAnchor, constant: 0)
            ])
        let trailingFromInfoButton = -((floatingTextField.frame.height * 0.8) + 16)
        floatingTextField.trailingLabelConstraint.constant = trailingFromInfoButton
        floatingTextField.trailingTextFieldConstraint.constant = trailingFromInfoButton
        floatingTextField.layoutIfNeeded()
    }

}
