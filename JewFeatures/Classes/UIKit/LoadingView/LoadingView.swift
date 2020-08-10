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
    var hasStarted = false
    
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
        trailingConstraint.constant = -frame.width
        trailingConstraint.isActive = true
        heightConstraint = self.heightAnchor.constraint(equalToConstant: height)
        heightConstraint.isActive = true
        layoutIfNeeded()
    }
    
    public func setupAdditionalConfiguration() {
        animatedView.horizontalMode = true
        animatedView.colors = [backgroundColor?.cgColor ?? UIColor.white.cgColor, UIColor.JEWDefault().cgColor]
        animatedView.setup()
    }
    
    public func update(colors: [CGColor]) {
        animatedView.colors = colors
        animatedView.setup()
    }
    
    public func start(animated: Bool = false) {
        if hasStarted == false {
            hasStarted = true
            self.leadingConstraint.constant = 0
            self.trailingConstraint.constant = -frame.width
            self.layoutIfNeeded()
            self.shouldAnimate = true
            changeHeight(animated: animated)
            moveRight()
        }
    }
    
    private func changeHeight(animated: Bool) {
        self.heightConstraint.constant = height
        if animated {
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
            return
        }
        self.layoutIfNeeded()
    }
    
    public func stop() {
        hasStarted = false
        shouldAnimate = false
        self.heightConstraint.constant = 0
        self.leadingConstraint.constant = 0
        self.trailingConstraint.constant = -self.frame.width
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
    
    public func complete(time: TimeInterval = 0, completion: (() -> Void)? = nil) {
        hasStarted = false
        shouldAnimate = false
        self.leadingConstraint.constant = 0
        self.trailingConstraint.constant = 0
        UIView.animate(withDuration: time, animations:  {
            self.layoutIfNeeded()
        }) { _ in
            completion?()
        }
    }
    
    public func empty() {
        hasStarted = false
        shouldAnimate = false
        self.leadingConstraint.constant = 0
        self.trailingConstraint.constant = -frame.width
        self.layoutIfNeeded()
    }
    
    func moveRight() {
        if shouldAnimate {
            self.trailingConstraint.constant = 0
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                self.layoutIfNeeded()
            }) { (finished) in
                if self.shouldAnimate {
                    self.leadingConstraint.constant = self.frame.width
                    UIView.animate(withDuration: 0.5, animations: {
                        self.layoutIfNeeded()
                    }) { _ in
                        self.leadingConstraint.constant = 0
                        self.trailingConstraint.constant = -self.frame.width
                        self.layoutIfNeeded()
                        if self.shouldAnimate {
                            self.moveRight()
                        }
                    }
                }
            }
        }
    }
}
