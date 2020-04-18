//
//  UIView+INVSExtension.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 13/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    
     private enum Values {
         static let splitNumber: CGFloat = 100
         static let lengthDash: NSNumber = 2
         static let lengthGap: NSNumber = 2
         static let dashLineWidth: CGFloat = 1
     }
     
     public var subviewsRecursive: [UIView] {
         return subviews + subviews.flatMap { $0.subviewsRecursive }
     }
     
     // MARK: - Public Methods
     
     /// Inicializa pelo NIB name
     ///
     /// - Parameters:
     ///   - withOwner: o responsavel da view
     ///   - options: parametros opcionais
     /// - Returns: Retorna o nib da view
     static public func fromNib<T>(withOwner: Any? = nil, options: [AnyHashable: Any]? = nil) -> T? where T: UIView {
         let bundle = Bundle(for: self)
         let nib = UINib(nibName: "\(self)", bundle: bundle)
         return nib.instantiate(withOwner: withOwner, options: options as? [UINib.OptionsKey: Any]).first as? T
     }
     
     /// Função para remvover o refresh control da view.
     public func removeRefreshControl() {
         for case let refresh as UIRefreshControl in subviews {
             refresh.removeFromSuperview()
         }
     }
     
     /// Função para remover todas as subviews.
     public func resetSubviews() {
         for subview in subviews {
             subview.removeFromSuperview()
         }
     }
     
     public func addBackground(color: UIColor, cornerRadius: CGFloat = 4) {
         let subView = UIView(frame: bounds)
         subView.backgroundColor = color
         addSubviewAttachingEdges(subView)
         subView.layer.roundCorners(radius: cornerRadius)
         
     }
     
     
     /// Função para Arredondar as Bordas da View
     ///
     /// - Parameters:
     ///   - corners: Array dos cantos da view
     ///   - radius: Tamanho do raio do cantos
     public func round(corners: UIRectCorner, radius: CGFloat) {
         _ = roundExtension(corners: corners, radius: radius)
     }
     
     /// Função para Customizar as Bordas da View
     ///
     /// - Parameters:
     ///   - corners: Array dos cantos da view
     ///   - radius: Tamanho do raio dos cantos
     ///   - borderColor: Cor da borda da view
     ///   - borderWidth: Tamanho da borda da view
     public func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
         let mask = roundExtension(corners: corners, radius: radius)
         addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
     }
     
     /// Função para adicionar linha tracejada na view
     ///
     /// - Parameters:
     ///   - p0: posição inicial da contrução da view
     ///   - p1: posição final da contrução da view
     ///   - view: View que recebe a linha tracejada
     public func drawDottedLine(start p0: CGPoint, end p1: CGPoint) {
         let shapeLayer = CAShapeLayer()
         shapeLayer.strokeColor = UIColor.lightGray.cgColor
         shapeLayer.lineWidth = Values.dashLineWidth
         shapeLayer.lineDashPattern = [Values.lengthDash, Values.lengthGap]
         
         let path = CGMutablePath()
         path.addLines(between: [p0, p1])
         shapeLayer.path = path
         self.layer.addSublayer(shapeLayer)
     }
     
     public func addGradient(startColor: CGColor, endColor: CGColor, startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 1), angle:(Double)? = nil, frame: CGRect? = nil) {
         
         guard !(self.layer.sublayers ?? []).contains(where: {$0 is CAGradientLayer}) else { return }
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
         gradient.colors = [startColor, endColor]
         gradient.frame = self.bounds
         if let frame = frame {
             gradient.frame = frame
         }
         
         self.layer.insertSublayer(gradient, at: 0)
     }
     
     
     public func setupPhotoView(withName name: String? = nil, withImage imageName: String? = nil, color: UIColor) -> UIView {
         if let name = name {
             let nameLabel = UILabel(frame: .zero)
             nameLabel.textColor = color
             nameLabel.text = name
             nameLabel.font = UIFont.JEW24()
             nameLabel.textAlignment = .center
             addSubviewAttachingEdges(nameLabel)
         }
         
         if let imageName = imageName {
             let nameImage = UIImage(named: imageName, in: JEWSession.bundle, compatibleWith: nil)
             let nameImageView = UIImageView(frame: .zero)
             nameImageView.image = nameImage
             nameImageView.tintColor = color
             addSubviewAttachingEdges(nameImageView)
         }
         
         return self
     }
     
     public func isAnimated(isHidden: Bool, finalAlpha: CGFloat = 1, duration: Double = 0.3, completion: (() -> ())? = nil) {
         
         UIView.animate(withDuration: duration, animations: { [weak self] in
             self?.isHidden = isHidden
             self?.alpha = isHidden ? 0 : finalAlpha
         }) { (finished) in
             if let completion = completion {
                 completion()
             }
         }
     }
     
     // MARK: - Private Methods
     
     private func roundExtension(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
         let path = UIBezierPath(roundedRect: bounds,
                                 byRoundingCorners: corners,
                                 cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
         return mask
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
    
    public static func toString() -> String {
           return String(describing: self.self)
    }
    public func addBlur(withBlurEffectStyle style: UIBlurEffect.Style = .dark) {
        let darkBlur = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = self.bounds
        self.addSubview(blurView)
    }
    public func animateBorderLayerColor(toColor: UIColor, duration: Double) {
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = layer.borderColor
        animation.toValue = toColor.cgColor
        animation.duration = duration
        layer.add(animation, forKey: "borderColor")
        layer.borderColor = toColor.cgColor
    }
    
    public func animateBackgroundLayerColor(toColor: UIColor, duration: Double) {
        let colourAnim = CABasicAnimation(keyPath: "backgroundColor")
        colourAnim.fromValue = layer.backgroundColor
        colourAnim.toValue = toColor.cgColor
        colourAnim.duration = duration
        layer.add(colourAnim, forKey: "colourAnimation")
        layer.backgroundColor = toColor.cgColor
    }
    
    public func setupRounded(borderColor: UIColor, cornerRadius: CGFloat? = nil) {
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
    
    public func setupEdgeConstraints(parent: UIView, useSafeLayout: Bool = false) {
        setupConstraints(parent: parent, top: 0, bottom: 0, leading: 0, trailing: 0, useSafeLayout: useSafeLayout)
    }
    
    public func setupConstraints(parent: UIView, top: CGFloat? = nil, bottom: CGFloat? = nil, topBottom: CGFloat? = nil, bottomTop: CGFloat? = nil, leading: CGFloat? = nil, trailing: CGFloat? = nil, centerX: CGFloat? = nil, centerY: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil, useSafeLayout: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchorConstraint = useSafeLayout ? parent.safeAreaLayoutGuide.topAnchor : parent.topAnchor
        let bottomAnchorConstraint = useSafeLayout ? parent.safeAreaLayoutGuide.bottomAnchor : parent.bottomAnchor
        let leadingAnchorConstraint = useSafeLayout ? parent.safeAreaLayoutGuide.leadingAnchor : parent.leadingAnchor
        let trailingAnchorConstraint = useSafeLayout ? parent.safeAreaLayoutGuide.trailingAnchor : parent.trailingAnchor
        
        if let top = top {
            self.topAnchor.constraint(equalTo: topAnchorConstraint, constant: top).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottomAnchorConstraint, constant: bottom).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailingAnchorConstraint, constant: trailing).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leadingAnchorConstraint, constant: leading).isActive = true
        }
        
        if let topBottom = topBottom {
            self.topAnchor.constraint(equalTo: parent.bottomAnchor, constant: topBottom).isActive = true
        }
        if let bottomTop = bottomTop {
            self.bottomAnchor.constraint(equalTo: parent.topAnchor, constant: bottomTop).isActive = true
        }
        
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: centerX).isActive = true
        }
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: centerY).isActive = true
        }
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
           self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
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
}
