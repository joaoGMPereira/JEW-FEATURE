//
//  UIView+INVSExtension.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 13/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    public func addBlur(withBlurEffectStyle style: UIBlurEffect.Style = .dark) {
        let darkBlur = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = self.bounds
        self.addSubview(blurView)
    }
    public func animateBorderLayerColor(toColor: UIColor, duration: Double) {
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = layer.borderColor
        animation.toValue = toColor.cgColor
        animation.duration = duration
        layer.add(animation, forKey: "borderColor")
        layer.borderColor = toColor.cgColor
    }
    
    public func animateBackgroundLayerColor(toColor: UIColor, duration: Double) {
        let colourAnim = CABasicAnimation(keyPath: "backgroundColor")
        colourAnim.fromValue = layer.backgroundColor
        colourAnim.toValue = toColor.cgColor
        colourAnim.duration = duration
        layer.add(colourAnim, forKey: "colourAnimation")
        layer.backgroundColor = toColor.cgColor
    }
    
    public func setupRounded(borderColor: UIColor, cornerRadius: CGFloat? = nil) {
        var radius = frame.width/2
        if let cornerRadius = cornerRadius {
            radius = cornerRadius
        }
        layer.borderWidth = 2
        layer.masksToBounds = false
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}
