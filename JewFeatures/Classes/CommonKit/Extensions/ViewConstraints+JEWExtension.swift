//
//  View+ConstraintsLifeSupport.swift
//  LifeSupport
//
//  Created by Joao Gabriel Medeiros Perei on 26/01/20.
//

import UIKit

extension UIView {
    private enum ValuesConstraint {
        static let visualFormatViewName = "view"
        static let verticalConstraint = "V:|[view]|"
        static let horizontalContraint = "H:|[view]|"
    }
    
    var safeAreaTop: CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
             return window?.safeAreaInsets.top ?? 0
        } else {
            return 0
        }
    }
    
    var safeAreaBottom: CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            return window?.safeAreaInsets.bottom ?? 0
        } else {
            return 0
        }
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leftAnchor
        } else {
            return self.leftAnchor
        }
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.rightAnchor
        } else {
            return self.rightAnchor
        }
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }
    
    var safeCenterXAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.centerXAnchor
        } else {
            return self.centerXAnchor
        }
    }
    
    var safeCenterYAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.centerYAnchor
        } else {
            return self.centerYAnchor
        }
    }
    
    /// Adciona a view preenchendo os espaços da super view
    ///
    /// - Parameters:
    ///   - view: view que sera adicionada
    ///   - verticalConstraint: constrante vertical da view
    ///   - horizontalConstraint: constrante horizontal da view
    func addSubviewAttachingEdges(_ view: UIView,
                                  verticalConstraint: String = UIView.ValuesConstraint.verticalConstraint,
                                  horizontalConstraint: String = UIView.ValuesConstraint.horizontalContraint) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        attachEdges(view, verticalConstraint: verticalConstraint, horizontalConstraint: horizontalConstraint)
    }
    
    /// Função para adicionar as constraints na view.
    ///
    /// - Parameters:
    ///   - view: View que receberá as constraints.
    ///   - verticalConstraint: Constraint vertical.
    ///   - horizontalConstraint: Constraint horizontal.
    ///   - views: View adicionadas.
    func attachEdges(_ view: UIView,
                     verticalConstraint: String? = UIView.ValuesConstraint.verticalConstraint,
                     horizontalConstraint: String? = UIView.ValuesConstraint.horizontalContraint,
                     views: [String: Any]? = nil) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let viewDictionary = views ?? [UIView.ValuesConstraint.visualFormatViewName: view]
        if let vertical = verticalConstraint {
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: vertical,
                                                          options: [],
                                                          metrics: nil,
                                                          views: viewDictionary))
        }
        if let horizontal = horizontalConstraint {
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: horizontal,
                                                          options: [],
                                                          metrics: nil,
                                                          views: viewDictionary))
        }
        view.layoutIfNeeded()
    }
    
    /// Ancorar a view pelo topo e base
    ///
    /// - Parameters:
    ///   - top: Onde o topo da view ira ancorar
    ///   - bottom: Onde a base da view ira ancorar
    ///   - paddingTop: Espaçamento do top
    ///   - paddingBottom: Espaçamento do bottom
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, paddingTop: CGFloat = 0.0, paddingBottom: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
    }
    
    /// Ancorar a view pela esquerda e direita
    ///
    /// - Parameters:
    ///   - left: Onde a esquerda da view ira ancorar
    ///   - right: Onde a direita da view ira ancorar
    ///   - paddingLeft: Espaçamento da esquerda
    ///   - paddingRight: Espaçamento da direita
    func anchor(left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingLeft: CGFloat = 0.0, paddingRight: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
    }
    
    /// Ancorar pela horizontal e vertical
    ///
    /// - Parameters:
    ///   - horizontal: Onde o alinhamento horizontal da view ira ancorar
    ///   - vertical: Onde o alinhamento vertical da view ira ancorar
    ///   - paddingHorizontal: Espaçamento do horizontal
    ///   - paddingVertical: Espaçamento do vertical
    func anchor(horizontal: NSLayoutXAxisAnchor?, vertical: NSLayoutYAxisAnchor?, paddingHorizontal: CGFloat = 0.0, paddingVertical: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let horizontal = horizontal {
            centerXAnchor.constraint(equalTo: horizontal, constant: paddingHorizontal).isActive = true
        }
        
        if let vertical = vertical {
            centerYAnchor.constraint(equalTo: vertical, constant: paddingVertical).isActive = true
        }
    }
    
    /// Ancorar pela largura e altura
    ///
    /// - Parameters:
    ///   - width: largura da view
    ///   - height: altura da view
    func anchor(width: CGFloat = 0.0, height: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    /// Ancorar o topo e a base maior ou igual
    ///
    /// - Parameters:
    ///   - topGreaterThanOrEqualTo: Onde o topo da view ira ancorar
    ///   - bottomGreaterThanOrEqualTo: Onde a base da view ira ancorar
    ///   - paddingTop: Espaçamento do top
    ///   - paddingBottom: Espaçamento da base
    func anchor(topGreater topGreaterThanOrEqualTo: NSLayoutYAxisAnchor?, bottomGreater bottomGreaterThanOrEqualTo: NSLayoutYAxisAnchor?, paddingTop: CGFloat = 0.0, paddingBottom: CGFloat = 0.0) {
        if let top = topGreaterThanOrEqualTo {
            topAnchor.constraint(greaterThanOrEqualTo: top, constant: paddingTop).isActive = true
        }
        
        if let bottom = bottomGreaterThanOrEqualTo {
            bottomAnchor.constraint(greaterThanOrEqualTo: bottom, constant: paddingBottom).isActive = true
        }
    }
    
    func adjustConstraints(to view: UIView, attributes: (top: CGFloat, trailing: CGFloat, leading: CGFloat, bottom: CGFloat) = (0, 0, 0, 0)) -> [NSLayoutConstraint] {
        
        return [
            NSLayoutConstraint(
                item: self, attribute: .top, relatedBy: .equal,
                toItem: view, attribute: .top, multiplier: 1.0,
                constant: attributes.top
            ),
            NSLayoutConstraint(
                item: self, attribute: .trailing, relatedBy: .equal,
                toItem: view, attribute: .trailing, multiplier: 1.0,
                constant: attributes.trailing
            ),
            NSLayoutConstraint(
                item: self, attribute: .leading, relatedBy: .equal,
                toItem: view, attribute: .leading, multiplier: 1.0,
                constant: attributes.leading
            ),
            NSLayoutConstraint(
                item: self, attribute: .bottom, relatedBy: .equal,
                toItem: view, attribute: .bottom, multiplier: 1.0,
                constant: attributes.bottom
            )
        ]
    }
    
    /// Applies auto layout constraints to Custom Nib
    ///
    /// - Parameter container: The containerView of view
    public func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    /// Applies auto layout constraints
    ///
    /// - Parameter constraints: The constraints to be applied
    public func applyConstraints(_ constraints: [String]) {
        guard let superview = superview else {
            preconditionFailure("`superview` was nil – call `addSubview(view: UIView)` before calling `bindEdgesToSuperview()` to fix this.")
        }
        translatesAutoresizingMaskIntoConstraints = false
        constraints.forEach { visualFormat in
            superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: visualFormat,
                                                                    options: .directionLeadingToTrailing,
                                                                    metrics: nil,
                                                                    views: ["subview": self]))
        }
    }
    
}
