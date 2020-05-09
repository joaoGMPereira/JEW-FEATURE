//
//  UIView+INVSExtension.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 13/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import UIKit
public extension UIView {
    
    private enum Values {
        static let splitNumber: CGFloat = 100
        static let lengthDash: NSNumber = 2
        static let lengthGap: NSNumber = 2
        static let dashLineWidth: CGFloat = 1
    }
    
    var subviewsRecursive: [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive }
    }
    
    // MARK: - Methods
    
    /// Inicializa pelo NIB name
    ///
    /// - Parameters:
    ///   - withOwner: o responsavel da view
    ///   - options: parametros opcionais
    /// - Returns: Retorna o nib da view
    static func fromNib<T>(withOwner: Any? = nil, options: [AnyHashable: Any]? = nil) -> T? where T: UIView {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)
        return nib.instantiate(withOwner: withOwner, options: options as? [UINib.OptionsKey: Any]).first as? T
    }
    
    /// Função para remvover o refresh control da view.
    func removeRefreshControl() {
        for case let refresh as UIRefreshControl in subviews {
            refresh.removeFromSuperview()
        }
    }
    
    /// Função para remover todas as subviews.
    func resetSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    /// Função para adicionar linha tracejada na view
    ///
    /// - Parameters:
    ///   - p0: posição inicial da contrução da view
    ///   - p1: posição final da contrução da view
    ///   - view: View que recebe a linha tracejada
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = Values.dashLineWidth
        shapeLayer.lineDashPattern = [Values.lengthDash, Values.lengthGap]
        
        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
    
    func setupPhotoView(withName name: String? = nil, withImage imageName: String? = nil, bundle: Bundle, color: UIColor) -> UIView {
        if let name = name {
            let nameLabel = UILabel(frame: .zero)
            nameLabel.textColor = color
            nameLabel.text = name
            nameLabel.font = UIFont.JEW24()
            nameLabel.textAlignment = .center
            addSubviewAttachingEdges(nameLabel)
        }
        
        if let imageName = imageName {
            let nameImage = UIImage(named: imageName, in: bundle, compatibleWith: nil)
            let nameImageView = UIImageView(frame: .zero)
            nameImageView.image = nameImage
            nameImageView.tintColor = color
            addSubviewAttachingEdges(nameImageView)
        }
        
        return self
    }
    
    func isAnimated(isHidden: Bool, finalAlpha: CGFloat = 1, duration: Double = 0.3, completion: (() -> ())? = nil) {
        
        UIView.animate(withDuration: duration, animations: { [weak self] in
            DispatchQueue.main.async {
                self?.isHidden = isHidden
                self?.alpha = isHidden ? 0 : finalAlpha
            }
        }) { (finished) in
            if let completion = completion {
                completion()
            }
        }
    }
    
    static func toString() -> String {
        return String(describing: self.self)
    }
    func addBlur(withBlurEffectStyle style: UIBlurEffect.Style = .dark) {
        let darkBlur = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = self.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurView)
    }
    func animateBorderLayerColor(toColor: UIColor, duration: Double) {
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = layer.borderColor
        animation.toValue = toColor.cgColor
        animation.duration = duration
        layer.add(animation, forKey: "borderColor")
        layer.borderColor = toColor.cgColor
    }
    
    func animateBackgroundLayerColor(toColor: UIColor, duration: Double) {
        let colourAnim = CABasicAnimation(keyPath: "backgroundColor")
        colourAnim.fromValue = layer.backgroundColor
        colourAnim.toValue = toColor.cgColor
        colourAnim.duration = duration
        layer.add(colourAnim, forKey: "colourAnimation")
        layer.backgroundColor = toColor.cgColor
    }
    
    func setupEdgeConstraints(parent: UIView, padding: CGFloat = 0, useSafeLayout: Bool = false) {
        setupConstraints(parent: parent, top: padding, bottom: -padding, leading: padding, trailing: -padding, useSafeLayout: useSafeLayout)
    }
    
    
    
    func setupConstraints(parent: UIView, top: CGFloat? = nil, bottom: CGFloat? = nil, topBottom: CGFloat? = nil, bottomTop: CGFloat? = nil, leading: CGFloat? = nil, leadingTrailing: CGFloat? = nil, trailing: CGFloat? = nil, trailingLeading: CGFloat? = nil, centerX: CGFloat? = nil, centerY: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil, useSafeLayout: Bool = false) {
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
        
        if let leadingTrailing = leadingTrailing {
            self.leadingAnchor.constraint(equalTo: parent.trailingAnchor, constant: leadingTrailing).isActive = true
        }
        
        if let trailingLeading = trailingLeading {
            self.trailingAnchor.constraint(equalTo: parent.leadingAnchor, constant: trailingLeading).isActive = true
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
    
    // retrieves all constraints that mention the view
    func getAllConstraints() -> [NSLayoutConstraint] {

        // array will contain self and all superviews
        var views = [self]

        // get all superviews
        var view = self
        while let superview = view.superview {
            views.append(superview)
            view = superview
        }

        // transform views to constraints and filter only those
        // constraints that include the view itself
        return views.flatMap({ $0.constraints }).filter { constraint in
            return constraint.firstItem as? UIView == self ||
                constraint.secondItem as? UIView == self
        }
    }
    
    // Example 1: Get all width constraints involving this view
    // We could have multiple constraints involving width, e.g.:
    // - two different width constraints with the exact same value
    // - this view's width equal to another view's width
    // - another view's height equal to this view's width (this view mentioned 2nd)
    func getWidthConstraints() -> [NSLayoutConstraint] {
        return getAllConstraints().filter( {
            ($0.firstAttribute == .width && $0.firstItem as? UIView == self) ||
            ($0.secondAttribute == .width && $0.secondItem as? UIView == self)
        } )
    }

    // Example 2: Change width constraint(s) of this view to a specific value
    // Make sure that we are looking at an equality constraint (not inequality)
    // and that the constraint is not against another view
    func changeWidth(to value: CGFloat) {

        getAllConstraints().filter( {
            $0.firstAttribute == .width &&
                $0.relation == .equal &&
                $0.secondAttribute == .notAnAttribute
        } ).forEach( {$0.constant = value })
    }

    // Example 3: Change leading constraints only where this view is
    // mentioned first. We could also filter leadingMargin, left, or leftMargin
    func changeLeading(to value: CGFloat) {
        getAllConstraints().filter( {
            $0.firstAttribute == .leading &&
                $0.firstItem as? UIView == self
        }).forEach({$0.constant = value})
    }
    
    func changeBottom(to value: CGFloat) {
        getAllConstraints().filter( {
            $0.firstAttribute == .bottom &&
                $0.firstItem as? UIView == self
        }).forEach({$0.constant = value})
    }
    
    func changeTop(to value: CGFloat) {
        getAllConstraints().filter( {
            $0.firstAttribute == .top &&
                $0.firstItem as? UIView == self
        }).forEach({$0.constant = value})
    }
}
