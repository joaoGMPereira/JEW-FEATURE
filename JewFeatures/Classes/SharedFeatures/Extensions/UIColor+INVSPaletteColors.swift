//
//  ISPaletteColors.swift
//  InvestEx_Example
//
//  Created by Joao Medeiros Pereira on 11/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    static func INVSPallete(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static func INVSDefault(withAlpha alpha: CGFloat = 1.0) -> UIColor {
        return UIColor.INVSPallete(red: 83, green: 77, blue: 185, alpha: alpha)
    }
    
    static func INVSLightDefault() -> UIColor {
        return UIColor.INVSPallete(red: 172, green: 126, blue: 189)
    }
    
    static func INVSGradientColors() -> [CGColor] {
        return [UIColor.INVSDefault().cgColor, UIColor.INVSLightDefault().cgColor]
    }
    
    static func INVSRed() -> UIColor {
        return UIColor.INVSPallete(red: 249, green: 66, blue: 47)
    }
    
    static func INVSGray() -> UIColor {
        return UIColor.INVSPallete(red: 239, green: 239, blue: 244)
    }
    
    static func INVSLightGray() -> UIColor {
        return UIColor.INVSPallete(red: 247, green: 247, blue: 247)
    }
    
    static func INVSBlack() -> UIColor {
        return UIColor.INVSPallete(red: 44, green: 44, blue: 44)
    }
}
