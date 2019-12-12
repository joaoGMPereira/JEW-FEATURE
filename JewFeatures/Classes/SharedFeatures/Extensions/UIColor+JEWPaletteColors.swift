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
    public static func JEWPallete(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    public static func JEWDefault() -> UIColor {
        return JEWUIColor.default.defaultColor
    }
    
    public static func JEWLightDefault() -> UIColor {
        return JEWUIColor.default.lightDefaultColor
    }
    
    public static func JEWGradientColors() -> [CGColor] {
        return [UIColor.JEWDefault().cgColor, UIColor.JEWLightDefault().cgColor]
    }
    
    public static func JEWRed() -> UIColor {
        return UIColor.JEWPallete(red: 249, green: 66, blue: 47)
    }
    
    public static func JEWGray() -> UIColor {
        return UIColor.JEWPallete(red: 239, green: 239, blue: 244)
    }
    
    public static func JEWLightGray() -> UIColor {
        return UIColor.JEWPallete(red: 247, green: 247, blue: 247)
    }
    
    public static func JEWBlack() -> UIColor {
        return UIColor.JEWPallete(red: 35, green: 35, blue: 35)
    }
    
    public static func JEWLightBlack() -> UIColor {
        return UIColor.JEWPallete(red: 105, green: 105, blue: 105)
    }
}

public class JEWUIColor: NSObject {
    static public let `default` = JEWUIColor()
    public var defaultColor:UIColor = .JEWBlack()
    public var lightDefaultColor:UIColor = .JEWLightGray()
}
