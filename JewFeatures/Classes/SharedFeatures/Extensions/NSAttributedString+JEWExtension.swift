//
//  NSAttributedString+JEWExtension.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 02/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    
    public static func title(withText text: String) -> NSAttributedString {
        return set(withText: text, andFont: UIFont.JEW24())
    }
    
    public static func titleBold(withText text: String) -> NSAttributedString {
        return set(withText: text, andFont: UIFont.JEW24Bold())
    }
    
    public static func subtitle(withText text: String) -> NSAttributedString {
        return set(withText: text, andFont: UIFont.JEW20())
    }
    
    public static func subtitleBold(withText text: String) -> NSAttributedString {
        return set(withText: text, andFont: UIFont.JEW20Bold())
    }
    
    public static func set(withText text: String, andFont font:UIFont) -> NSAttributedString {
        return NSAttributedString.init(string: text, attributes: [NSAttributedString.Key.font : font])
    }
    
    
    public func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    public func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}
