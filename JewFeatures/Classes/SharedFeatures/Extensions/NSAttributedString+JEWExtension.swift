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
    
    public static func title(withText text: String, color: UIColor) -> NSAttributedString {
        return set(withText: text, andFont: UIFont.JEW24(), andColor: color)
    }
    
    public static func titleBold(withText text: String, color: UIColor) -> NSAttributedString {
        return set(withText: text, andFont: UIFont.JEW24Bold(), andColor: color)
    }
    
    public static func subtitle(withText text: String, color: UIColor) -> NSAttributedString {
        return set(withText: text, andFont: UIFont.JEW20(), andColor: color)
    }
    
    public static func subtitleBold(withText text: String, color: UIColor) -> NSAttributedString {
        return set(withText: text, andFont: UIFont.JEW20Bold(), andColor: color)
    }
    
    public static func set(withText text: String, andFont font:UIFont) -> NSAttributedString {
        return NSAttributedString.init(string: text, attributes: [NSAttributedString.Key.font : font])
    }
    
    public static func set(withText text: String, andFont font:UIFont, andColor color:UIColor) -> NSAttributedString {
        return NSAttributedString.init(string: text, attributes: [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor: color])
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
    
    public func newLabelWith(with widthConstraint: NSLayoutConstraint)  {
        
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: widthConstraint.constant, height: CGFloat(MAXFLOAT)))
        let frameSetterRef : CTFramesetter = CTFramesetterCreateWithAttributedString(self as CFAttributedString)
        let frameRef: CTFrame = CTFramesetterCreateFrame(frameSetterRef, CFRangeMake(0, 0), path.cgPath, nil)
        
        let linesNS: NSArray  = CTFrameGetLines(frameRef)
        
        guard let lines = linesNS as? [CTLine] else {return }
        var width = 0.0
        lines.forEach({
            let nextWidth = Double(CTLineGetBoundsWithOptions($0, CTLineBoundsOptions.useGlyphPathBounds).width)
            if nextWidth > width {
                width = nextWidth
            }
        })
        
        widthConstraint.constant = CGFloat(width + 30)
        
    }
}
