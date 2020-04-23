//
//  LifeSupportToolTip.swift
//  LifeSupport
//
//  Created by Joao Gabriel Medeiros Perei on 09/02/20.
//

import Foundation

enum LifeSupportTooltipPosition {
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

struct LifeSupportTooltipConfig {
    var title: String = ""
    var text: String = ""
    var titleColor: UIColor = .white
    var textColor: UIColor = UIColor.white.withAlphaComponent(0.6)
    var titleFont: UIFont = .systemFont(ofSize: 13)
    var textFont: UIFont = .systemFont(ofSize: 12)
    var backgroundColor: UIColor = UIColor.init(red: 82/255, green: 34/255, blue: 107/255, alpha: 1)
    var cornerRadius: CGFloat = 5
    var animated: Bool = true
    var position: LifeSupportTooltipPosition = .topRight
    var offsetArrowX: CGFloat = 8
    var offsetArrowY: CGFloat = 8
    var arrowHeight: CGFloat = 6
    var lineBreakMode: NSLineBreakMode = NSLineBreakMode.byWordWrapping
    var padding: UIEdgeInsets = UIEdgeInsets.init(top: 12, left: 12, bottom: 12, right: 12)
    var marginInset: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)

}

typealias LifeSupportTooltipCompletion = ((_ tooltip: UIControl) -> ())

class LifeSupportTooltip: NSObject, LifeSupportTooltipProtocol {
    
    var tooltipView: UIControl? = nil
    private var messageLabel: UILabel? = nil
    private var arrowView: UIView? = nil
    private var anchorView: UIView? = nil
    private var superview: UIView? = nil
    private var config: LifeSupportTooltipConfig? = nil
    private var showCompletion: LifeSupportTooltipCompletion? = nil
    private var dismissCompletion: LifeSupportTooltipCompletion? = nil
    
    
    func show(withSuperview superview: UIView, anchorView: UIView, config: LifeSupportTooltipConfig) {
        show(withSuperview: superview, anchorView: anchorView, config: config, showCompletion: nil, dismissCompletion: nil)
    }
    
    func show(withSuperview superview: UIView, anchorView: UIView, config: LifeSupportTooltipConfig, showCompletion: LifeSupportTooltipCompletion?, dismissCompletion: LifeSupportTooltipCompletion?) {
        self.showCompletion = showCompletion
        self.dismissCompletion = dismissCompletion
        self.config = config
        self.anchorView = anchorView
        self.superview = superview
        
        self.show(animated: config.animated)
    }
    
    func dismiss(animated: Bool) {
        dismissTooltip(animated: animated)
    }
}

extension LifeSupportTooltip: LifeSupportTooltipSetupProtocol {
    func show(animated: Bool) {
        setup()
        showTooltip(animated: animated)
    }
    
    func setup() {
        let tooltipView = setupTooltipView(withFrame: self.tooltipRect())
        self.superview?.addSubview(tooltipView)
        self.tooltipView = tooltipView
        let messageLabel = setupMessageLabel(withFrame: self.messageRect())
        tooltipView.addSubview(messageLabel)
        self.messageLabel = messageLabel
        let arrowView = self.arrowView(withFrame: self.arrowViewRect())
        tooltipView.insertSubview(arrowView, at: 0)
        self.arrowView = arrowView
    }
    
    func setupTooltipView(withFrame frame: CGRect) -> UIControl {
        guard let config = config else {
            return UIControl(frame: .zero)
        }
        var tooltipView = UIControl(frame: frame)
        configure(withTooltipView: tooltipView, config: config)
        return tooltipView
    }
    
    
    func configure(withTooltipView tooltipView: UIControl, config: LifeSupportTooltipConfig) {
        tooltipView.translatesAutoresizingMaskIntoConstraints = false
        tooltipView.backgroundColor = config.backgroundColor
        tooltipView.layer.cornerRadius = config.cornerRadius
    }
    
    func setupMessageLabel(withFrame frame: CGRect) -> UILabel {
        guard let config = config else {
            return UILabel.init(frame: .zero)
        }
        let messageLabel = UILabel.init(frame: frame)
        configure(withMessageLabel: messageLabel, config: config)
        return messageLabel
    }
    
    func configure(withMessageLabel messageLabel: UILabel, config: LifeSupportTooltipConfig) {
        messageLabel.numberOfLines = 0
        messageLabel.backgroundColor = UIColor.clear
        messageLabel.adjustsFontSizeToFitWidth = true
        messageLabel.attributedText = self.attributedStringFullText()
        messageLabel.lineBreakMode = config.lineBreakMode
        messageLabel.minimumScaleFactor = 0.9
    }
    
    func arrowView(withFrame frame: CGRect) -> UIView {
        let arrowView = UIView(frame: frame)
        configure(withArrowView: arrowView)
        return arrowView
    }
    
    func configure(withArrowView arrowView: UIView) {
        arrowView.backgroundColor = self.config?.backgroundColor
        arrowView.transform = CGAffineTransform(rotationAngle: CGFloat(-45.0 * M_PI/180.0))
    }
}

extension LifeSupportTooltip: LifeSupportTooltipConfigProtocol {
    func changeConfig(config: LifeSupportTooltipConfig) {
        self.config = config
        if (tooltipView != nil) {
            reloadTooltip()
        }
    }
    
    func currentConfiguration() -> LifeSupportTooltipConfig? {
        return self.config
    }
    
    func reloadTooltip() {
        if let tooltipView = tooltipView, let config = config {
            tooltipView.frame = tooltipRect()
            configure(withTooltipView: tooltipView, config: config)
        }
        if let messageLabel = messageLabel, let config = config {
            messageLabel.frame = messageRect()
            configure(withMessageLabel: messageLabel, config: config)
        }
        if let arrowView = arrowView {
            arrowView.frame = arrowViewRect()
            configure(withArrowView: arrowView)
        }
    }
}


extension LifeSupportTooltip: LifeSupportTooltipTextProtocol {
    func hasValid(string: String) -> Bool {
        return string != nil && string.count > 0
    }
    
    func hasValidTitle() -> Bool {
        guard let title = self.config?.title else {
            return false
        }
        return self.hasValid(string: title)
    }
    
    func hasValidText() -> Bool {
        guard let text = self.config?.text else {
            return false
        }
        return self.hasValid(string: text)
    }
    
    func attributedStringFullText() -> NSAttributedString {
        var mutableAttributedText = NSMutableAttributedString()
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


extension LifeSupportTooltip: LifeSupportTooltipCalculationProtocol {
    
    func tooltipRect() -> CGRect {
        guard let config = config, let anchorView = anchorView, let superview = superview else {
            return .zero
        }
        var boundingRect = messageRect()
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
    
    func hypotenuse() -> CGFloat {
        guard let arrowHeight = self.config?.arrowHeight else {
            return  CGFloat.leastNonzeroMagnitude
        }
        return CGFloat(hypotf(Float(arrowHeight), Float(arrowHeight)))
    }
    
    func minWidth() -> CGFloat {
        guard let config = config else {
            return CGFloat.leastNonzeroMagnitude
        }
        return config.cornerRadius + config.padding.left + config.padding.right + self.hypotenuse()
    }
    
    func maxWidth() -> CGFloat {
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
    
    func messageRect() -> CGRect {
        guard let config = config, let anchorView = self.anchorView, let superview = self.superview else {
            return .zero
        }
        
        let maxWidth = self.maxWidth() - config.padding.left - config.padding.right
        var boudingRect = self.attributedStringFullText().boundingRect(with: CGSize.init(width: maxWidth, height: .greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        boudingRect.origin.x += config.padding.left
        boudingRect.origin.y += config.padding.top
        boudingRect.size.width = ceil(boudingRect.size.width)
        boudingRect.size.height = ceil(boudingRect.size.height)
        return boudingRect
    }
    
    func leftTopPositionArrowRect() -> CGRect {
        guard let config = config else {
            return .zero
        }
        var origin: CGPoint = .zero
        origin.y = config.arrowHeight + config.offsetArrowY
        origin.x = -config.arrowHeight/2
        return CGRect.init(x: origin.x, y: origin.y, width: config.arrowHeight, height: config.arrowHeight)
    }
    
    func rightTopPositionArrowRect() -> CGRect {
        guard let config = config, let tooltipView = self.tooltipView else {
            return .zero
        }
        var origin: CGPoint = .zero
        origin.y = config.arrowHeight + config.offsetArrowY
        origin.x = tooltipView.frame.width - config.arrowHeight/2
        return CGRect.init(x: origin.x, y: origin.y, width: config.arrowHeight, height: config.arrowHeight)
    }
    
    func leftBottomPositionArrowRect() -> CGRect {
        guard let config = config, let tooltipView = self.tooltipView else {
            return .zero
        }
        var origin: CGPoint = .zero
        origin.y = tooltipView.frame.height - config.arrowHeight - config.offsetArrowY
        origin.x = -config.arrowHeight/2
        return CGRect.init(x: origin.x, y: origin.y, width: config.arrowHeight, height: config.arrowHeight)
    }
    
    func rightBottomPositionArrowRect() -> CGRect {
        guard let config = config, let tooltipView = self.tooltipView else {
            return .zero
        }
        var origin: CGPoint = .zero
        origin.y = tooltipView.frame.height - config.arrowHeight - config.offsetArrowY
        origin.x = tooltipView.frame.width - config.arrowHeight/2
        return CGRect.init(x: origin.x, y: origin.y, width: config.arrowHeight, height: config.arrowHeight)
    }
    
    func centerBottomPositionArrowRect() -> CGRect {
        guard let config = config, let tooltipView = self.tooltipView else {
            return .zero
        }
        var origin: CGPoint = .zero
        origin.y = -config.arrowHeight/2
        origin.x = tooltipView.frame.width/2 - config.arrowHeight/2
        return CGRect.init(x: origin.x, y: origin.y, width: config.arrowHeight, height: config.arrowHeight)
    }
    
    func centerTopPositionArrowRect() -> CGRect {
        guard let config = config, let tooltipView = self.tooltipView else {
            return .zero
        }
        var origin: CGPoint = .zero
        origin.y = tooltipView.frame.height - config.arrowHeight/2
        origin.x = tooltipView.frame.width/2 - config.arrowHeight/2
        return CGRect.init(x: origin.x, y: origin.y, width: config.arrowHeight, height: config.arrowHeight)
    }
    
    func arrowViewRect() -> CGRect {
        guard let config = config, let tooltipView = self.tooltipView else {
            return .zero
        }
        var initialX = (self.hypotenuse() - config.arrowHeight)/2
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

extension LifeSupportTooltip: LifeSupportTooltipAnimationProtocol {
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
