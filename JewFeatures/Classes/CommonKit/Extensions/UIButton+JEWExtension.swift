//
//  UIButton+INVSExtension.swift
//  InvestScopio_Example
//
//  Created by Joao Medeiros Pereira on 19/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    
    /// Sets the background's image, clipping its borders, which is required
    /// by buttons with rounded borders.
    ///
    /// - Parameters:
    ///   - image: The image to be used
    ///   - state: The `UIButton` state to apply the image
    func setBackgroundImageClippedToBounds(_ image: UIImage, for state: UIControl.State) {
        if !(layer.cornerRadius != 0.0) {
            setBackgroundImage(image, for: state)
            return
        }
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).addClip()
        image.draw(in: bounds)
        let clippedBackgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        setBackgroundImage(clippedBackgroundImage, for: state)
    }
    
    /// Sets Background color.
    ///
    /// - Parameters:
    ///   - color: The color to be set
    ///   - state: The `UIControl.State` to apply the color.
    public func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        if let backgroundImage = UIImage.image(withColor: color) {
            self.setBackgroundImageClippedToBounds(backgroundImage, for: state)
        }
    }
    
    open override var isEnabled: Bool {
        didSet {
            UIView.animate(withDuration: 1.2, animations: {
                self.alpha = self.isEnabled ? 1.0 : 0.7
            })
        }
    }
    
}
