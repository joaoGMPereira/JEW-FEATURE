//
//  UIView+Round.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 21/04/20.
//

import Foundation
import UIKit

public extension UIView {
    
    func addGradient(colors: [CGColor], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 1), angle:(Double)? = nil, frame: CGRect? = nil, cornerRadius: CGFloat = 0) {
           removeAllLayers()
           let gradient = CAGradientLayer()
           
           if let angle = angle {
               let StartXOffset = 0.75
               let EndXOffset = 0.25
               let EndYOffset = 0.5
               let angleNormalized = angle/360.0
               let startX = pow(sin((2 * .pi * ((angleNormalized + StartXOffset) / 2.0))), 2.0)
               let startY = pow(sin(2 * .pi * (angleNormalized/2)), 2.0)
               let endX = pow(sin(2 * .pi * (angleNormalized + EndXOffset)), 2)
               let endY = pow(sin(2 * .pi * (angleNormalized + EndYOffset)), 2)
               gradient.startPoint = CGPoint(x: startX, y: startY)
               gradient.endPoint = CGPoint(x: endX, y: endY)
           } else {
               gradient.startPoint = startPoint
               gradient.endPoint = endPoint
           }
           gradient.colors = colors
           gradient.frame = self.bounds
           gradient.cornerRadius = cornerRadius
           if let frame = frame {
               gradient.frame = frame
           }
           
           self.layer.insertSublayer(gradient, at: 0)
       }
       
    
    func addBackground(color: UIColor, cornerRadius: CGFloat = 4) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        addSubviewAttachingEdges(subView)
        subView.round(radius: cornerRadius)
    }
    
    func roundCornersRadii(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: topLeft, y: 0))
        path.addLine(to: CGPoint(x: bounds.width - topRight, y: 0))
        path.addArc(withCenter: CGPoint(x: bounds.width - topRight, y: topRight),
                    radius: topRight,
                    startAngle: -CGFloat.pi/2.0,
                    endAngle: 0,
                    clockwise: true)
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.width - bottomRight))
        path.addArc(withCenter: CGPoint(x: bounds.width - bottomRight, y: bounds.height - bottomRight),
                    radius: bottomRight,
                    startAngle: 0,
                    endAngle: CGFloat.pi/2.0,
                    clockwise: true)
        path.addLine(to: CGPoint(x: bottomRight, y: bounds.height))
        path.addArc(withCenter: CGPoint(x: bottomLeft, y: bounds.height - bottomLeft),
                    radius: bottomLeft,
                    startAngle: CGFloat.pi/2.0,
                    endAngle: CGFloat.pi,
                    clockwise: true)
        path.addLine(to: CGPoint(x: 0, y: topLeft))
        path.addArc(withCenter: CGPoint(x: topLeft, y: topLeft),
                    radius: topLeft,
                    startAngle: CGFloat.pi,
                    endAngle: CGFloat.pi/2.0,
                    clockwise: true)
        path.close()
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    /// Função para Customizar as Bordas da View
    ///
    /// - Parameters:
    ///   - corners: Array dos cantos da view
    ///   - radius: Tamanho do raio dos cantos
    ///   - borderColor: Cor da borda da view
    ///   - borderWidth: Tamanho da borda da view
    func round(corners: UIRectCorner = .allCorners, radius: CGFloat, backgroundColor: UIColor = .clear, borderColor: UIColor = .clear, borderWidth: CGFloat = 0, withShadow shadow: Bool = false) {
        removeAllLayers()
        var mask = roundExtension(corners: corners, radius: radius, backgroundColor: backgroundColor)
        if shadow {
            mask = addShadow(mask: mask)
            
        }
        self.layer.insertSublayer(mask, at: 0)
        if borderWidth > 0 {
            addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
        }
        
    }
    
    func rounded(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundAllCorners(borderColor: UIColor, cornerRadius: CGFloat? = nil) {
        var radius = frame.width/2
        if let cornerRadius = cornerRadius {
            radius = cornerRadius
        }
        layer.borderWidth = 2
        layer.masksToBounds = false
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = radius
        clipsToBounds = true
        
    }
    
    // MARK: - Private Methods
    
    private func roundExtension(corners: UIRectCorner, radius: CGFloat, backgroundColor: UIColor = .clear) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.bounds = frame
        mask.position = center
        mask.path = path.cgPath
        mask.fillColor = backgroundColor.cgColor
        return mask
    }
    
    private func removeAllLayers() {
        layer.sublayers?.removeAll(where: { (layer) -> Bool in
            return (layer.classForCoder == CAShapeLayer.self || layer.classForCoder == CAGradientLayer.self)
        })
    }
    
    private func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
    
    private func addShadow(mask: CAShapeLayer) -> CAShapeLayer {
        let shadowLayer = mask
        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        shadowLayer.shadowOpacity = 0.4
        shadowLayer.shadowRadius = 1
        return shadowLayer
    }
}
