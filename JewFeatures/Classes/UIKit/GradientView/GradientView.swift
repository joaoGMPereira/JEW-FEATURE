//
//  GradientView.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 20/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
public class GradientView: UIView {
    public var colors: [CGColor] = [UIColor.black.cgColor, UIColor.white.cgColor]
    public var startColor:   UIColor = .black { didSet { updateColors() }}
    public var endColor:     UIColor = .white { didSet { updateColors() }}
    public var startLocation: Double =   0.05 { didSet { updateLocations() }}
    public var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    public var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    public var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    
    override public class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 1, y: 0.5)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = colors
    }
    
    public func setup() {
        updatePoints()
        updateLocations()
        updateColors()
    }
}
