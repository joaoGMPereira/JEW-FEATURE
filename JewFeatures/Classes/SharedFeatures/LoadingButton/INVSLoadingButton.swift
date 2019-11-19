//
//  INVSLoadingButton.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 14/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class INVSLoadingButton: UIView {
    let button = UIButton(frame: .zero)
    let loadingView = AnimationView()
    var buttonAction: ((_ button: UIButton) -> ())?
    var buttonTitle = ""
    var loadingJson = ""
    
    func setupFill(withColor color: UIColor = UIColor.INVSDefault(), title: String, andRounded isRounded: Bool = true) {
        loadingJson = "animatedLoadingWhite"
        setupView()
        buttonTitle = title
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(color, for: .normal)
        let _ = CAShapeLayer.addCorner(withShapeLayer: nil, withCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], withRoundedCorner: isRounded ? button.frame.height/2 : 0, andColor: color, inView: button)
        
    }
    
    func setupFillGradient(withColor colors: [CGColor] = UIColor.INVSGradientColors(), title: String, andRounded isRounded: Bool = true) {
        loadingJson = "animatedLoadingWhite"
        setupView()
        buttonTitle = title
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        let _ = CAShapeLayer.addGradientLayer(withGradientLayer: nil, inView: button, withColorsArr: colors, withRoundedCorner: isRounded ? button.frame.height/2 : 0)
    }
    
    func setupBorded(withColor color: UIColor = UIColor.INVSDefault(), title: String, andRounded isRounded: Bool = true) {
        loadingJson = "animatedLoadingPurple"
        setupView()
        buttonTitle = title
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.layer.borderColor = color.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = isRounded ? button.frame.height/2 : 0
    }
    
    func setupSkeleton() {
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
    
    func setHideSkeleton() {
        hideSkeleton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isSkeletonActive {
            layoutSkeletonIfNeeded()
        }
    }
    
    func showLoading() {
        self.loadingView.play()
        self.button.isUserInteractionEnabled = false
        self.button.setTitle("", for: .normal)
        self.loadingView.alpha = 1.0
    }
    
    func hideLoading() {
        UIView.animate(withDuration: 0.6) {
            self.button.isUserInteractionEnabled = true
            self.button.setTitle(self.buttonTitle, for: .normal)
            self.loadingView.alpha = 0.0
        }
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        if let buttonAction = buttonAction {
            buttonAction(sender)
        }
    }
}

extension INVSLoadingButton: INVSCodeView {
    func buildViewHierarchy() {
        self.addSubview(button)
        self.addSubview(loadingView)
        button.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
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
    
    func setupAdditionalConfiguration() {
        self.layoutIfNeeded()
        let loadAnimation = Animation.named(loadingJson)
        loadingView.animation = loadAnimation
        loadingView.contentMode = .scaleAspectFit
        loadingView.animationSpeed = 1.0
        loadingView.loopMode = .loop
        loadingView.alpha = 0.0
        self.button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
    }
}
