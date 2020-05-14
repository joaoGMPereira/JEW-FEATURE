//
//  UILabel+JEWExtension.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 14/05/20.
//

import UIKit

public extension UILabel {
    static func createLabel(text: String, color: UIColor, font: UIFont) -> UILabel {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = text
        label.textColor = color
        label.font = font
        label.sizeToFit()
        return label
    }
    
    static func createLabel(attributedText: NSAttributedString) -> UILabel {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.attributedText = attributedText
        label.sizeToFit()
        return label
    }
    
    static func createLabel(priceWithDiscount:String, price: String) -> UILabel {
        let mutableAttributedString = NSMutableAttributedString()
        let priceWithDiscountAttributedString = NSAttributedString.init(string: "\(priceWithDiscount) ", attributes: [NSAttributedString.Key.font : UIFont.JEW16Bold(), NSAttributedString.Key.foregroundColor : UIColor.JEWBlack()])
        let priceAttributedString = NSAttributedString.init(string: price, attributes: [NSAttributedString.Key.font : UIFont.JEW16(), NSAttributedString.Key.foregroundColor : UIColor.JEWLightBlack(), NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
        mutableAttributedString.append(priceWithDiscountAttributedString)
        mutableAttributedString.append(priceAttributedString)
        
        return createLabel(attributedText: mutableAttributedString)
    }
}
