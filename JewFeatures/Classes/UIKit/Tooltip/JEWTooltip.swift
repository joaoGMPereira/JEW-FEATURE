//
//  JEWToolTip.swift
//  JEW
//
//  Created by Joao Gabriel Medeiros Perei on 09/02/20.
//

import Foundation

public enum JEWTooltipPosition {
    case topRight
    case topLeft
    case bottomRight
    case bottomLeft
    case leftTop
    case leftBottom
    case rightTop
    case rightBottom
    case centerTop
    case centerBottom
}

public struct JEWTooltipConfig {
    public var customView: UIView?
    public var height: CGFloat?
    public var title: String = String()
    public var text: String = String()
    public var titleColor: UIColor = .white
    public var textColor: UIColor = UIColor.white.withAlphaComponent(0.6)
    public var titleFont: UIFont = .systemFont(ofSize: 13)
    public var textFont: UIFont = .systemFont(ofSize: 12)
    public var backgroundColor: UIColor = UIColor.init(red: 82/255, green: 34/255, blue: 107/255, alpha: 1)
    public var cornerRadius: CGFloat = 5
    public var shadow: Bool = false
    public var animated: Bool = true
    public var position: JEWTooltipPosition = .topRight
    public var offsetArrowX: CGFloat = 8
    public var offsetArrowY: CGFloat = 8
    public var arrowHeight: CGFloat = 6
    public var lineBreakMode: NSLineBreakMode = NSLineBreakMode.byWordWrapping
    public var padding: UIEdgeInsets = UIEdgeInsets.init(top: 12, left: 12, bottom: 12, right: 12)
    public var marginInset: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    
    public init() {
        
    }

}

public typealias JEWTooltipCompletion = ((_ tooltip: UIControl) -> ())

public class JEWTooltip: NSObject, JEWTooltipProtocol {
    
    public var tooltipView: UIControl? = nil
    private var customView: UIView? = nil
    private var messageLabel: UILabel? = nil
    private var arrowView: UIView? = nil
    private var anchorView: UIView? = nil
    private var superview: UIView? = nil
    private var config: JEWTooltipConfig? = nil
    private var showCompletion: JEWTooltipCompletion? = nil
    private var dismissCompletion: JEWTooltipCompletion? = nil
    
    
    public func show(withSuperview superview: UIView, anchorView: UIView, config: JEWTooltipConfig) {
        show(withSuperview: superview, anchorView: anchorView, config: config, showCompletion: nil, dismissCompletion: nil)
    }
    
    public func show(withSuperview superview: UIView, anchorView: UIView, config: JEWTooltipConfig, showCompletion: JEWTooltipCompletion?, dismissCompletion: JEWTooltipCompletion?) {
        self.showCompletion = showCompletion
        self.dismissCompletion = dismissCompletion
        self.config = config
        self.anchorView = anchorView
        self.superview = superview
        
        self.show(animated: config.animated)
    }
    
    public func dismiss(animated: Bool) {
        dismissTooltip(animated: animated)
    }
}

extension JEWTooltip: JEWTooltipSetupProtocol {
    public func show(animated: Bool) {
        setup()
        showTooltip(animated: animated)
    }
    
    public func setup() {
        let tooltipView = setupTooltipView(withFrame: self.tooltipRect())
        self.superview?.addSubview(tooltipView)
        self.tooltipView = tooltipView
        setupContentView(tooltipView: tooltipView)
        let arrowView = self.arrowView(withFrame: self.arrowViewRect())
        tooltipView.insertSubview(arrowView, at: 0)
        self.arrowView = arrowView
        tooltipView.addTarget(self, action: #selector(tapDismissToolTip), for: .touchUpInside)
    
    }
    
    func setupContentView(tooltipView: UIControl) {
        guard let customView = config?.customView else {
            let messageLabel = setupMessageLabel(withFrame: self.contentRect())
            tooltipView.addSubview(messageLabel)
            self.messageLabel = messageLabel
            return
        }
        customView.frame = self.contentRect()
        tooltipView.addSubview(customView)
        self.customView = customView
        
    }
    
    public func setupTooltipView(withFrame frame: CGRect) -> UIControl {
        guard let config = config else {
            return UIControl(frame: .zero)
        }
        let tooltipView = UIControl(frame: frame)
        configure(withTooltipView: tooltipView, config: config)
        return tooltipView
    }
    
    
    public func configure(withTooltipView tooltipView: UIControl, config: JEWTooltipConfig) {
        tooltipView.translatesAutoresizingMaskIntoConstraints = false
        tooltipView.round(radius: config.cornerRadius, backgroundColor: config.backgroundColor, withShadow: config.shadow)
    }
    
    public func setupMessageLabel(withFrame frame: CGRect) -> UILabel {
        guard let config = config else {
            return UILabel.init(frame: .zero)
        }
        let messageLabel = UILabel.init(frame: frame)
        configure(withMessageLabel: messageLabel, config: config)
        return messageLabel
    }
    
    public func configure(withMessageLabel messageLabel: UILabel, config: JEWTooltipConfig) {
        messageLabel.numberOfLines = 0
        messageLabel.backgroundColor = UIColor.clear
        messageLabel.adjustsFontSizeToFitWidth = true
        messageLabel.attributedText = self.attributedStringFullText()
        messageLabel.lineBreakMode = config.lineBreakMode
        messageLabel.minimumScaleFactor = 0.9
    }
    
    public func arrowView(withFrame frame: CGRect) -> UIView {
        let arrowView = UIView(frame: frame)
        configure(withArrowView: arrowView)
        return arrowView
    }
    
    public func configure(withArrowView arrowView: UIView) {
        arrowView.backgroundColor = self.config?.backgroundColor
        arrowView.transform = CGAffineTransform(rotationAngle: CGFloat(-45.0 * .pi/180.0))
    }
    
    @objc func tapDismissToolTip() {
        self.dismiss(animated: true)
    }
}

extension JEWTooltip: JEWTooltipConfigProtocol {
    public func changeConfig(config: JEWTooltipConfig) {
        self.config = config
        if (tooltipView != nil) {
            reloadTooltip()
        }
    }
    
    public func currentConfiguration() -> JEWTooltipConfig? {
        return self.config
    }
    
    public func reloadTooltip() {
        if let tooltipView = tooltipView, let config = config {
            tooltipView.frame = tooltipRect()
            configure(withTooltipView: tooltipView, config: config)
        }
        if let messageLabel = messageLabel, let config = config {
            messageLabel.frame = contentRect()
            configure(withMessageLabel: messageLabel, config: config)
        }
        if let arrowView = arrowView {
            arrowView.frame = arrowViewRect()
            configure(withArrowView: arrowView)
        }
    }
}


extension JEWTooltip: JEWTooltipTextProtocol {
    public func hasValid(string: String) -> Bool {
        return string.count > 0
    }
    
    public func hasValidTitle() -> Bool {
        guard let title = self.config?.title else {
            return false
        }
        return self.hasValid(string: title)
    }
    
    public func hasValidText() -> Bool {
        guard let text = self.config?.text else {
            return false
        }
        return self.hasValid(string: text)
    }
    
    public func attributedStringFullText() -> NSAttributedString {
        let mutableAttributedText = NSMutableAttributedString()
        guard let config = config else {
            return mutableAttributedText
        }
        if hasValidTitle() {
            let titleAttributes = [NSAttributedString.Key.foregroundColor: config.titleColor, NSAttributedString.Key.font: config.titleFont]
            let attributedTitle = NSAttributedString(string: "\(config.title)\(self.hasValidText() ? "\n" : String())", attributes: titleAttributes)
            mutableAttributedText.append(attributedTitle)
        }
        
        if hasValidText() {
            let textAttributes = [NSAttributedString.Key.foregroundColor: config.textColor, NSAttributedString.Key.font: config.textFont]
            let attributedText = NSAttributedString(string: config.text, attributes: textAttributes)
            mutableAttributedText.append(attributedText)
        }
        
        return mutableAttributedText
    }
}


extension JEWTooltip: JEWTooltipCalculationProtocol {
    
    public func tooltipRect() -> CGRect {
        guard let config = config, let anchorView = anchorView, let superview = superview else {
            return .zero
        }
        var boundingRect = contentRect()
        boundingRect.size.width += config.padding.left + config.padding.right
        boundingRect.size.width = fmax(boundingRect.size.width, minWidth())
        boundingRect.size.height += config.padding.bottom + config.padding.top
        boundingRect.origin = anchorView.superview?.convert(anchorView.frame.origin, to: superview) ?? .zero
        if config.position == .topLeft ||
            config.position == .bottomLeft ||
            config.position == .leftTop ||
            config.position == .leftBottom {
            boundingRect.origin.x += config.marginInset.left
        } else if config.position == .centerTop || config.position == .centerBottom {
            boundingRect.origin.x += (anchorView.frame.width/2) - (boundingRect.width/2)
        } else {
            boundingRect.origin.x += anchorView.frame.width - boundingRect.width - config.marginInset.right
        }
        
        if config.position == .rightTop || config.position == .rightBottom {
            boundingRect.origin.x -= config.marginInset.left
        }
        
        if config.position == .topLeft || config.position == .topRight || config.position == .centerTop {
            boundingRect.origin.y -= boundingRect.height + config.arrowHeight
        } else {
            boundingRect.origin.y += anchorView.frame.height + config.arrowHeight
        }
        
        boundingRect.origin.y += config.marginInset.top
        
        return boundingRect
    }
    
    public func hypotenuse() -> CGFloat {
        guard let arrowHeight = self.config?.arrowHeight else {
            return  CGFloat.leastNonzeroMagnitude
        }
        return CGFloat(hypotf(Float(arrowHeight), Float(arrowHeight)))
    }
    
    public func minWidth() -> CGFloat {
        guard let config = config else {
            return CGFloat.leastNonzeroMagnitude
        }
        return config.cornerRadius + config.padding.left + config.padding.right + self.hypotenuse()
    }
    
    public func maxWidth() -> CGFloat {
        guard let config = config, let anchorView = self.anchorView, let superview = self.superview else {
            return .leastNonzeroMagnitude
        }
        guard let realOrigin = anchorView.superview?.convert(anchorView.frame.origin, to: self.superview) else {
            return .leastNonzeroMagnitude
        }
        var maxWidth: CGFloat = .leastNonzeroMagnitude
        if config.position == .topLeft ||
            config.position == .bottomLeft ||
            config.position == .leftTop ||
            config.position == .leftBottom {
            maxWidth = superview.frame.width - realOrigin.x
        } else {
            maxWidth = realOrigin.x + anchorView.frame.width
        }
        maxWidth -= config.marginInset.left + config.marginInset.right
        return CGFloat(fmaxf(Float(self.minWidth()), Float(maxWidth)))
    }
    
    public func contentRect() -> CGRect {
        guard let config = config, let _ = self.anchorView, let _ = self.superview else {
            return .zero
        }
        let maxWidth = self.maxWidth() - config.padding.left - config.padding.right
        if let customView = config.customView, let height = config.height {
            var boudingRect: CGRect = customView.frame
            boudingRect.origin.x += config.padding.left
            boudingRect.origin.y += config.padding.top
            boudingRect.size.width = ceil(maxWidth)
            boudingRect.size.height = ceil(height)
            return boudingRect
        }
        return messageRect(maxWidth: maxWidth, config: config)
    }
    
    private func messageRect(maxWidth: CGFloat, config: JEWTooltipConfig) -> CGRect {
        
        var boudingRect = self.attributedStringFullText().boundingRect(with: CGSize.init(width: maxWidth, height: .greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        boudingRect.origin.x += config.padding.left
        boudingRect.origin.y += config.padding.top
        boudingRect.size.width = ceil(boudingRect.size.width)
        boudingRect.size.height = ceil(boudingRect.size.height)
        return boudingRect
    }
    
    public func leftTopPositionArrowRect() -> CGRect {
        guard let config = config else {
            return .zero
        }
        var origin: CGPoint = .zero
        origin.y = config.arrowHeight + config.offsetArrowY
        origin.x = -config.arrowHeight/2
        return CGRect.init(x: origin.x, y: origin.y, width: config.arrowHeight, height: config.arrowHeight)
    }
    
    public func rightTopPositionArrowRect() -> CGRect {
        guard let config = config, let tooltipView = self.tooltipView else {
            return .zero
        }
        var origin: CGPoint = .zero
        origin.y = config.arrowHeight + config.offsetArrowY
        origin.x = tooltipView.frame.width - config.arrowHeight/2
        return CGRect.init(x: origin.x, y: origin.y, width: config.arrowHeight, height: config.arrowHeight)
    }
    
    public func leftBottomPositionArrowRect() -> CGRect {
        guard let config = config, let tooltipView = self.tooltipView else {
            return .zero
        }
        var origin: CGPoint = .zero
        origin.y = tooltipView.frame.height - config.arrowHeight - config.offsetArrowY
        origin.x = -config.arrowHeight/2
        return CGRect.init(x: origin.x, y: origin.y, width: config.arrowHeight, height: config.arrowHeight)
    }
    
    public func rightBottomPositionArrowRect() -> CGRect {
        guard let config = config, let tooltipView = self.tooltipView else {
            return .zero
        }
        var origin: CGPoint = .zero
        origin.y = tooltipView.frame.height - config.arrowHeight - config.offsetArrowY
        origin.x = tooltipView.frame.width - config.arrowHeight/2
        return CGRect.init(x: origin.x, y: origin.y, width: config.arrowHeight, height: config.arrowHeight)
    }
    
    public func centerBottomPositionArrowRect() -> CGRect {
        guard let config = config, let tooltipView = self.tooltipView else {
            return .zero
        }
        var origin: CGPoint = .zero
        origin.y = -config.arrowHeight/2
        origin.x = tooltipView.frame.width/2 - config.arrowHeight/2
        return CGRect.init(x: origin.x, y: origin.y, width: config.arrowHeight, height: config.arrowHeight)
    }
    
    public func centerTopPositionArrowRect() -> CGRect {
        guard let config = config, let tooltipView = self.tooltipView else {
            return .zero
        }
        var origin: CGPoint = .zero
        origin.y = tooltipView.frame.height - config.arrowHeight/2
        origin.x = tooltipView.frame.width/2 - config.arrowHeight/2
        return CGRect.init(x: origin.x, y: origin.y, width: config.arrowHeight, height: config.arrowHeight)
    }
    
    public func arrowViewRect() -> CGRect {
        guard let config = config, let tooltipView = self.tooltipView else {
            return .zero
        }
        let initialX = (self.hypotenuse() - config.arrowHeight)/2
        var origin = CGPoint(x: initialX + config.offsetArrowX, y: -(config.arrowHeight/2))
        switch config.position {
        case .topRight:
            origin.y = tooltipView.frame.height - (config.arrowHeight/2)
            origin.x = tooltipView.frame.width - config.arrowHeight - config.offsetArrowX - initialX
            break
        case .topLeft:
            origin.y = tooltipView.frame.height - (config.arrowHeight / 2.0)
            break
        case .bottomRight:
            origin.x = tooltipView.frame.width - config.arrowHeight - config.offsetArrowX - initialX
            break
        case .bottomLeft:
            break
        case .leftTop:
            return self.leftTopPositionArrowRect()
        case .leftBottom:
            return self.leftBottomPositionArrowRect()
        case .rightTop:
            return self.rightTopPositionArrowRect()
        case .rightBottom:
            return self.rightBottomPositionArrowRect()
        case .centerTop:
            return centerTopPositionArrowRect()
        case .centerBottom:
            return centerBottomPositionArrowRect()
        }
        let compensation = fmax(config.cornerRadius, initialX)
        let maxX = tooltipView.frame.width - compensation - config.arrowHeight
        origin.x = fmin(fmax(origin.x, compensation), maxX)
        return CGRect(x: origin.x, y: origin.y, width: config.arrowHeight, height: config.arrowHeight)
    }
    
}

extension JEWTooltip: JEWTooltipAnimationProtocol {
    func showTooltip(animated: Bool) {
        if animated {
            self.tooltipView?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                self.tooltipView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { (finished) in
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                    self.tooltipView?.transform = .identity
                }, completion: { (finished) in
                    self.finishShow()
                })
            }
            return
        }
        finishShow()
    }
    
    func finishShow() {
        if let showCompletion = self.showCompletion, let tooltipView = self.tooltipView {
            showCompletion(tooltipView)
        }
    }
    
    func dismissTooltip(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                self.tooltipView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { (finished) in
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                    self.tooltipView?.alpha = 0
                    self.tooltipView?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                }, completion: { (finished) in
                    self.finishDismiss()
                })
            }
            return
        }
        finishDismiss()
    }
    
    func finishDismiss() {
        if let dismissCompletion = self.dismissCompletion, let tooltipView = self.tooltipView {
            dismissCompletion(tooltipView)
        }
        self.tooltipView?.removeFromSuperview()
        self.tooltipView = nil
    }
}
