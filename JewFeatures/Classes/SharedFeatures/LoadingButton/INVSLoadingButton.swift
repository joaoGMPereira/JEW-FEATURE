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

public class JEWLoadingButton: UIView {
    let button = UIButton(frame: .zero)
    let loadingView = AnimationView()
    var buttonAction: ((_ button: UIButton) -> ())?
    var buttonTitle = ""
    var loadingJson = ""
    
    public func setupFill(withColor color: UIColor = UIColor.JEWDefault(), title: String, andRounded isRounded: Bool = true) {
        loadingJson = "animatedLoadingWhite"
        setupView()
        buttonTitle = title
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(color, for: .normal)
        let _ = CAShapeLayer.addCorner(withShapeLayer: nil, withCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], withRoundedCorner: isRounded ? button.frame.height/2 : 0, andColor: color, inView: button)
        
    }
    
    public func setupFillGradient(withColor colors: [CGColor] = UIColor.JEWGradientColors(), title: String, andRounded isRounded: Bool = true) {
        loadingJson = "animatedLoadingWhite"
        setupView()
        buttonTitle = title
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        let _ = CAShapeLayer.addGradientLayer(withGradientLayer: nil, inView: button, withColorsArr: colors, withRoundedCorner: isRounded ? button.frame.height/2 : 0)
    }
    
    public func setupBorded(withColor color: UIColor = UIColor.JEWDefault(), title: String, andRounded isRounded: Bool = true) {
        loadingJson = "animatedLoadingPurple"
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
        if let bundle = PodAsset.bundle(forPod: "JewFeatures") {
        let loadAnimation = Animation.named(loadingJson, bundle: bundle)
            loadingView.animation = loadAnimation
            loadingView.contentMode = .scaleAspectFit
            loadingView.animationSpeed = 1.0
            loadingView.loopMode = .loop
            loadingView.alpha = 0.0
        }
        self.button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
    }
}
