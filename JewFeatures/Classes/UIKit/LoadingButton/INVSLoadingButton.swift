//
//  JEWLoadingButton.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 14/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import UIKit
import Lottie
import SkeletonView
import PodAsset

public enum JEWLoadingButtonType {
    case fill(color: UIColor, isRounded: Bool)
    case gradient(colors: [CGColor], isRounded: Bool)
    case bordered(color: UIColor, isRounded: Bool)
    case customRounds(color: UIColor, isBordered: Bool, topLeft: CGFloat, bottomLeft: CGFloat, topRight: CGFloat, bottomRight: CGFloat)
    
    func setup(button: UIButton) {
        switch self {
        case .fill(let color, let isRounded):
            setupFill(button: button, color: color, isRounded: isRounded)
            break
        case .gradient(let colors, let isRounded):
            setupGradient(button: button, colors: colors, isRounded: isRounded)
            break
        case .bordered(let color, let isRounded):
            setupBordered(button: button, color: color, isRounded: isRounded)
            break
        case .customRounds(let color, let isBordered, let topLeft, let bottomLeft, let topRight, let bottomRight):
            setupCustomRounds(button: button, color: color, isBordered: isBordered, topLeft: topLeft, bottomLeft: bottomLeft, topRight: topRight, bottomRight: bottomRight)
            break
        }
    }
    
    private func setupFill(button: UIButton, color: UIColor, isRounded: Bool) {
        button.setTitleColor(.white, for: .normal)
        button.round(radius: isRounded ? button.frame.height/2 : 0, backgroundColor: color, withShadow: true)
    }
    
    private func setupGradient(button: UIButton, colors: [CGColor], isRounded: Bool) {
        button.setTitleColor(.white, for: .normal)
        button.addGradient(colors: colors, cornerRadius: isRounded ? button.frame.height/2 : 0)
    }
    
    private func setupBordered(button: UIButton, color: UIColor, isRounded: Bool) {
        button.setTitleColor(color, for: .normal)
        button.layer.borderColor = color.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = isRounded ? button.frame.height/2 : 0
    }
    
    private func setupCustomRounds(button: UIButton, color: UIColor, isBordered: Bool, topLeft: CGFloat, bottomLeft: CGFloat, topRight: CGFloat, bottomRight: CGFloat) {
        button.setTitleColor(.white, for: .normal)
        if isBordered {
            button.layer.borderColor = color.cgColor
            button.layer.borderWidth = 2
            button.setTitleColor(color, for: .normal)
        }
        button.backgroundColor = color
        button.roundCornersRadii(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight)
    }
}

public class JEWLoadingButton: UIView {
    public let button = UIButton(frame: .zero)
    public let loadingView = AnimationView()
    public var buttonAction: ((_ button: UIButton) -> ())?
    public var buttonTitle = ""
    public var loadingJson = ""
    
    public func setup(type: JEWLoadingButtonType, title: String) {
        loadingJson = JEWConstants.Resources.Lotties.animatedLoadingWhite.rawValue
        setupView()
        buttonTitle = title
        button.setTitle(buttonTitle, for: .normal)
        type.setup(button: button)
    }
    
    public func setupFill(withColor color: UIColor = UIColor.JEWDefault(), title: String, andRounded isRounded: Bool = true) {
        loadingJson = JEWConstants.Resources.Lotties.animatedLoadingWhite.rawValue
        setupView()
        buttonTitle = title
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.round(radius: isRounded ? button.frame.height/2 : 0, backgroundColor: color, withShadow: true)
        
    }
    
    public func setupFillGradient(withColor colors: [CGColor] = UIColor.JEWGradientColors(), title: String, andRounded isRounded: Bool = true) {
        button.setTitleColor(.white, for: .normal)
        button.addGradient(colors: colors, cornerRadius: isRounded ? button.frame.height/2 : 0)
    }
    
    public func setupBorded(withColor color: UIColor = UIColor.JEWDefault(), lottie: JEWConstants.Resources.Lotties = .animatedLoadingBlack, title: String, andRounded isRounded: Bool = true) {
        loadingJson = lottie.rawValue
        setupView()
        buttonTitle = title
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.layer.borderColor = color.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = isRounded ? button.frame.height/2 : 0
    }
    
    public func setupSkeleton() {
        button.setTitle("", for: .normal)
        button.setTitleColor(.clear, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0
        setupView()
        isSkeletonable = true
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.height/2
        showAnimatedGradientSkeleton()
    }
    
    public func setHideSkeleton() {
        hideSkeleton()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public func showLoading() {
        self.loadingView.play()
        self.button.isUserInteractionEnabled = false
        self.button.setTitle("", for: .normal)
        self.loadingView.alpha = 1.0
    }
    
    public func hideLoading() {
        UIView.animate(withDuration: 0.6) {
            self.button.isUserInteractionEnabled = true
            self.button.setTitle(self.buttonTitle, for: .normal)
            self.loadingView.alpha = 0.0
        }
    }
    
    @objc public func buttonClicked(_ sender: UIButton) {
        if let buttonAction = buttonAction {
            buttonAction(sender)
        }
    }
}

extension JEWLoadingButton: JEWCodeView {
    public func buildViewHierarchy() {
        self.addSubview(button)
        self.addSubview(loadingView)
        button.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 40),
            loadingView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        self.layoutIfNeeded()
        if let bundle = PodAsset.bundle(forPod: JEWConstants.Resources.podsJewFeature.rawValue) {
            let loadAnimation = Animation.named(loadingJson, bundle: bundle)
            loadingView.backgroundBehavior = .pauseAndRestore
            loadingView.animation = loadAnimation
            loadingView.contentMode = .scaleAspectFit
            loadingView.animationSpeed = 1.0
            loadingView.loopMode = .loop
            loadingView.alpha = 0.0
        }
        self.button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
    }
}
