//
//  OptionView.swift
//  DailyRewards
//
//  Created by Joao Gabriel Medeiros Perei on 28/11/19.
//  Copyright © 2019 Joao Gabriel Medeiros Perei. All rights reserved.
//

import UIKit

public enum OptionType {
    case biometric
    case notification
    
    public func title() -> String {
        switch self {
            case .biometric:
                return JEWBiometrics.faceIDAvailable() ? JEWConstants.EnableBiometricViewController.enableFaceId.rawValue : JEWConstants.EnableBiometricViewController.enableTouchId.rawValue
            case .notification:
                return "Habilitar Notificação"
        }
    }
}

public class OptionView: UIView {
    var containerView = UIView(frame: .zero)
    var titleLabel = UILabel(frame: .zero)
    public var isOnSwitch = UISwitch(frame: .zero)
    var type: OptionType?
    public var changeOptionCallback: ((_ type: OptionType, _ isOn: Bool) -> ())?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupInfo(type: OptionType, isOn: Bool) {
        self.type = type
        titleLabel.text = type.title()
        isOnSwitch.isOn = isOn
    }
    
}

extension OptionView: JEWCodeView {
    public func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(isOnSwitch)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        isOnSwitch.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            isOnSwitch.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            isOnSwitch.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            isOnSwitch.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
            ])
    }
    
    public func setupAdditionalConfiguration() {
        backgroundColor = .JEWBlack()
        titleLabel.textColor = .white
        titleLabel.font = .JEW16Bold()
        isOnSwitch.onTintColor = .JEWDefault()
        isOnSwitch.addTarget(self, action: #selector(optionChange(_:)), for: .valueChanged)
        
    }
    
    @objc func optionChange(_ sender: UISwitch) {
        if let type = type, let changeOptionCallback = changeOptionCallback {
            changeOptionCallback(type, sender.isOn)
        }
    }
    
    
}
