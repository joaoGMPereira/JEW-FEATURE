//
//  Layer+Animation.swift
//  JewFeatures
//
//  Created by Joao Gabriel Medeiros Perei on 09/12/19.
//

import Foundation
import UIKit
public typealias FinishAnimation = (() -> Void)
public extension CALayer {
    func animate(fromValue: CGFloat = 1.00, toValue: CGFloat = 1.03, duration: TimeInterval = 0.3, finish: FinishAnimation? = nil) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = duration
        pulse.fromValue = fromValue
        pulse.toValue = toValue
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        add(pulse, forKey: nil)
    }
    
    func flash() {
    let flash = CABasicAnimation(keyPath: "opacity")
    flash.duration = 0.3
    flash.fromValue = 1
    flash.toValue = 0.1
    flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    flash.autoreverses = true
    flash.repeatCount = 2
    add(flash, forKey: nil)
    }
}
