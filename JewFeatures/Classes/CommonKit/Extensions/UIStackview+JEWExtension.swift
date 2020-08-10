//
//  UIStackview+INVSExtension.swift
//  InvestScopio_Example
//
//  Created by Joao Medeiros Pereira on 19/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    func addArranged(views: [UIView]) {
        views.forEach { (view) in
            addArrangedSubview(view)
        }
    }
    
    func removeArranged(views: [UIView]) {
        views.forEach { (view) in
            removeArrangedSubview(view)
        }
    }
    
    static func addLabel(with title: String, and value: String, font: UIFont, textColor: UIColor, valueTextAlignment: NSTextAlignment = .right) -> UIStackView {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = textColor
        titleLabel.numberOfLines = 0
        
        let valueLabel = UILabel(frame: .zero)
        valueLabel.text = value
        valueLabel.font = font
        valueLabel.textColor = textColor
        valueLabel.numberOfLines = 0
        valueLabel.textAlignment = valueTextAlignment
        
        let stackView = UIStackView.init(arrangedSubviews: [titleLabel, valueLabel])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }
    
    static func add(button: UIButton, imageName: String?) -> UIStackView {
        var views: [UIView] = [button]
        
        if let imageName = imageName, let image = UIImage(named: imageName) {
            let imageView = UIImageView.init(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
            views.append(imageView)
        }
        
        let stackView = UIStackView.init(arrangedSubviews: views)
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }
    
    static func add(title: String, font: UIFont, textColor: UIColor, imageName: String?) -> UIStackView {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = textColor
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        var views: [UIView] = [titleLabel]
        
        if let imageName = imageName, let image = UIImage(named: imageName) {
            let imageView = UIImageView.init(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
            views.append(imageView)
        }
        
        let stackView = UIStackView.init(arrangedSubviews: views)
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }
}
