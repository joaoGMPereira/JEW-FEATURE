//
//  UILabel+JEWExtension.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 14/05/20.
//

import UIKit

public extension UILabel {
    static func createLabel(text: String, color: UIColor, font: UIFont, textAlignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = text
        label.textAlignment = textAlignment
        label.textColor = color
        label.font = font
        
        return label
    }
    
    static func createLabel(attributedText: NSAttributedString, textAlignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.attributedText = attributedText
        label.textAlignment = textAlignment
        return label
    }
    
    static func createLabel(priceWithDiscount:String, price: String, textAlignment: NSTextAlignment = .center) -> UILabel {
        let mutableAttributedString = NSMutableAttributedString()
        let priceWithDiscountAttributedString = NSAttributedString.init(string: "\(priceWithDiscount) ", attributes: [NSAttributedString.Key.font : UIFont.JEW16Bold(), NSAttributedString.Key.foregroundColor : UIColor.JEWBlack()])
        let priceAttributedString = NSAttributedString.init(string: price, attributes: [NSAttributedString.Key.font : UIFont.JEW16(), NSAttributedString.Key.foregroundColor : UIColor.JEWLightBlack(), NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
        mutableAttributedString.append(priceWithDiscountAttributedString)
        mutableAttributedString.append(priceAttributedString)
        
        return createLabel(attributedText: mutableAttributedString, textAlignment: textAlignment)
    }
    
    func append(text: String, color: UIColor, font: UIFont, breakline: Bool = false) {
        let updatedText = "\(text)\(breakline ? "\n" : String())"
        let mutableAttributedString = NSMutableAttributedString(attributedString: self.attributedText ?? NSAttributedString())
        mutableAttributedString.append(NSAttributedString.init(string: updatedText, attributes: [NSAttributedString.Key.foregroundColor : color, NSAttributedString.Key.font : font]))
        self.attributedText = mutableAttributedString
    }
}

public extension UIButton {
    func append(text: String, color: UIColor, font: UIFont, breakline: Bool = false) {
        let updatedText = "\(text)\(breakline ? "\n" : String())"
        let mutableAttributedString = NSMutableAttributedString(attributedString: self.titleLabel?.attributedText ?? NSAttributedString())
        mutableAttributedString.append(NSAttributedString.init(string: updatedText, attributes: [NSAttributedString.Key.foregroundColor : color, NSAttributedString.Key.font : font]))
        self.setAttributedTitle(mutableAttributedString, for: .normal)
    }
}
