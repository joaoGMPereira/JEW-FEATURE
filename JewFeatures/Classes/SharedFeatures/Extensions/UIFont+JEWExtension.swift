//
//  UIFont+JEWExtension.swift
//  
//
//  Created by Joao Medeiros Pereira on 14/05/19.
//

import Foundation
import UIKit
extension UIFont {
    
    static func JEWSmallFontDefault() -> UIFont {
        return UIFont.systemFont(ofSize: 13)
    }
    
    static func JEWSmallFontDefaultBold() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 13)
    }
    
    static func JEWFontDefault() -> UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    
    static func JEWFontDefaultBold() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 14)
    }
    
    static func JEWFontBig() -> UIFont {
        return UIFont.systemFont(ofSize: 16)
    }
    
    static func JEWFontBigBold() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 16)
    }
    
    static func JEWTitleBold() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 24)
    }
    
    static func JEWTitle() -> UIFont {
        return UIFont.systemFont(ofSize: 24)
    }
    
    static func JEWSubtitleBold() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 20)
    }
    
    static func JEWSubtitle() -> UIFont {
        return UIFont.systemFont(ofSize: 20)
    }
}
