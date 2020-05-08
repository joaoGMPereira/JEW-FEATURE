//
//  LoadingView.swift
//  Challenge_Example
//
//  Created by Joao Gabriel Pereira on 08/05/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public class LoadingView: UIView {
    public var height: CGFloat = 0
    let animatedView = GradientView(frame: .zero)
    var leadingConstraint = NSLayoutConstraint()
    var trailingConstraint = NSLayoutConstraint()
    var heightConstraint = NSLayoutConstraint()
    var shouldAnimate = false
    
    override public init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

extension LoadingView: JEWCodeView {
    public func buildViewHierarchy() {
        addSubview(animatedView)
    }
    
    public func setupConstraints() {
        animatedView.setupConstraints(parent: self, top: 0, bottom: 0)
        leadingConstraint = animatedView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        leadingConstraint.isActive = true
        trailingConstraint = animatedView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        trailingConstraint.isActive = true
        heightConstraint = self.heightAnchor.constraint(equalToConstant: height)
        heightConstraint.isActive = true
        layoutIfNeeded()
    }
    
    public func setupAdditionalConfiguration() {
        animatedView.colors = [UIColor.white.cgColor, UIColor.JEWDefault().cgColor]
        animatedView.setup()
    }
    
    public func start() {
        self.leadingConstraint.constant = 0
        self.trailingConstraint.constant = -frame.width
        self.layoutIfNeeded()
        self.shouldAnimate = true
        moveRight()
    }
    
    public func stop() {
        shouldAnimate = false
        self.heightConstraint.constant = 0
        self.leadingConstraint.constant = 0
        self.trailingConstraint.constant = -self.frame.width
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
    
    func moveRight() {
        if shouldAnimate {
            self.trailingConstraint.constant = 0
            self.heightConstraint.constant = height
            UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: {
                self.layoutIfNeeded()
            }) { (finished) in
                self.leadingConstraint.constant = self.frame.width
                UIView.animate(withDuration: 0.5, animations: {
                    self.layoutIfNeeded()
                }) { _ in
                    self.leadingConstraint.constant = 0
                    self.trailingConstraint.constant = -self.frame.width
                    self.layoutIfNeeded()
                    self.moveRight()
                }
            }
        }
    }
}
