//
//  UIImage+LifeSupport.swift
//  LifeSupport
//
//  Created by Joao Gabriel Medeiros Perei on 05/02/20.
//

import UIKit

public extension UIImage {
    
    /// Creates a new 1x1 image with the given parameters.
    ///
    /// - Parameter color: The color to be used to fill the created image
    /// - Returns: The new image
    static func image(withColor color: UIColor) -> UIImage? {
        return self.image(withColor: color, size: CGSize(width: 1.0, height: 1.0))
    }
    
    /// Creates a new 1x1 image with the given parameters.
    ///
    /// - Parameters:
    ///   - color: The color to be used to fill the created image
    ///   - size: Final image size
    /// - Returns: A new image with given size and color
    static func image(withColor color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
