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
           floatingTextField.infoButton = UIButton.init(type: .infoLight)
           if let infoButton = floatingTextField.infoButton {
               floatingTextField.addSubview(infoButton)
               infoButton.translatesAutoresizingMaskIntoConstraints = false
               infoButton.tintColor = floatingTextField.infoButtonColor
               infoButton.addTarget(self, action: #selector(JEWFloatingTextField.infoButtonTapped(_:)), for: .touchUpInside)
               let size = floatingTextField.frame.height * 0.8
               NSLayoutConstraint.activate([
                   infoButton.safeRightAnchor.constraint(equalTo: floatingTextField.safeRightAnchor, constant: -8),
                   infoButton.heightAnchor.constraint(equalToConstant: size),
                   infoButton.widthAnchor.constraint(equalToConstant: size),
                   infoButton.centerYAnchor.constraint(equalTo: floatingTextField.safeCenterYAnchor, constant: 0)
                   ])
               let trailingFromInfoButton = -((floatingTextField.frame.height * 0.8) + 16)
               floatingTextField.trailingLabelConstraint.constant = trailingFromInfoButton
               floatingTextField.trailingTextFieldConstraint.constant = trailingFromInfoButton
               floatingTextField.layoutIfNeeded()
           }
       }


}
