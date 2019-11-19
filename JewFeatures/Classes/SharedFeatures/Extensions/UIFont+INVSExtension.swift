//
//  UIFont+INVSExtension.swift
//  
//
//  Created by Joao Medeiros Pereira on 14/05/19.
//

import Foundation
import UIKit
extension UIFont {
    
    static func INVSSmallFontDefault() -> UIFont {
        return UIFont.systemFont(ofSize: 13)
    }
    
    static func INVSSmallFontDefaultBold() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 13)
    }
    
    static func INVSFontDefault() -> UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    
    static func INVSFontDefaultBold() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 14)
    }
    
    static func INVSFontBig() -> UIFont {
        return UIFont.systemFont(ofSize: 16)
    }
    
    static func INVSFontBigBold() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 16)
    }
    
    static func INVSTitleBold() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 24)
    }
    
    static func INVSTitle() -> UIFont {
        return UIFont.systemFont(ofSize: 24)
    }
    
    static func INVSSubtitleBold() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 20)
    }
    
    static func INVSSubtitle() -> UIFont {
        return UIFont.systemFont(ofSize: 20)
    }
}
