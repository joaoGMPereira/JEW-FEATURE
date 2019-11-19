//
//  JEWOfflineViewController.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 15/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import UIKit

class INVSAlertViewController: INVSBlurViewController {
    var titleLabel = UILabel(frame: .zero)
    var messageLabel = UILabel(frame: .zero)
    var buttonStackView = UIStackView(frame: .zero)
    var confirmButton = JEWLoadingButton(frame: .zero)
    var cancelButton = UIButton(frame: .zero)
    var confirmCallback: ((_ button: UIButton) -> ())?
    var cancelCallback: ((_ button: UIButton) -> ())?
    
    var titleAlert: String = ""
    var messageAlert: String = ""
    var hasCancelButton: Bool = true
    init() {
        super.init(nibName: INVSBlurViewController.toString(), bundle: Bundle(for: INVSBlurViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.layoutIfNeeded()
        confirmButton.setupBorded(title: "Confirmar")
        confirmButton.buttonAction = {(button) -> () in
            self.confirmButton.showLoading()
            if let confirmCallback = self.confirmCallback {
                confirmCallback(self.confirmButton.button)
            }
        }
    }

    @objc func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        if let cancelCallback = self.cancelCallback {
            cancelCallback(sender)
        }
    }

}

extension INVSAlertViewController: JEWCodeView {
    func buildViewHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(messageLabel)
        contentView.addSubview(buttonStackView)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.safeAreaLayoutGuide.bottomAnchor,constant: 0),
            ])
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            buttonStackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor,constant: 8),
            buttonStackView.heightAnchor.constraint(equalToConstant: 40),
            buttonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            ])
    }
    
    func setupAdditionalConfiguration() {
        titleLabel.textColor = .JEWBlack()
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        titleLabel.font = .JEWFontBigBold()
        titleLabel.text = titleAlert
        messageLabel.textColor = .JEWBlack()
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.font = .JEWFontDefault()
        messageLabel.text = messageAlert
        if hasCancelButton {
            buttonStackView.addArrangedSubview(cancelButton)
        }
        buttonStackView.addArrangedSubview(confirmButton)
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 8
        buttonStackView.distribution = .fillEqually
        confirmButton.buttonAction = {(button) -> () in
            if let confirmCallback = self.confirmCallback {
                confirmCallback(button)
            }
        }
        cancelButton.layer.cornerRadius = 20
        cancelButton.layer.borderColor = UIColor.JEWRed().cgColor
        cancelButton.layer.borderWidth = 2
        cancelButton.setTitle("Cancelar", for: .normal)
        cancelButton.setTitleColor(.JEWRed(), for: .normal)
        cancelButton.addTarget(self, action: #selector(INVSAlertViewController.cancelAction(_:)), for: .touchUpInside)
    }
    
    
}
