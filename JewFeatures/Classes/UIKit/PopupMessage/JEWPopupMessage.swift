//
//  JEWPopupMessage.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 13/05/19.
//

import Foundation
import UIKit

public protocol JEWPopupMessageDelegate {
    func didFinishDismissPopupMessage(withPopupMessage popupMessage:JEWPopupMessage)
}

public class JEWPopupMessage: UIView {
    //MARK: Enums
    public var popupLayout: JEWPopupMessageLayout = .top
    var popupType: JEWPopupMessageType = .alert
    private var messageColor: UIColor = JEWPopupMessageType.error.messageColor()
    private var popupBackgroundColor: UIColor = JEWPopupMessageType.error.backgroundColor()
    
    //MARK: Hide Properties
    private var timerToHide = Timer()
    private var shouldHideAutomatically = true
    
    //MARK: Add view
    private var parentViewController = UIViewController()
    private var hasAddedSubview = false
    
    //MARK: Message
    private var messageAttributed = NSMutableAttributedString()
    
    //MARK: Size
    private var popupHeight = CGFloat(60.0)
    private var popupWidth = CGFloat(200)
    
    //MARK: Constraints
    private var topConstraint = NSLayoutConstraint()
    private var heightLabelConstraint = NSLayoutConstraint()
    
    //MARK: UI
    private var sender: UIView?
    var textMessageLabel = UILabel()
    var closeButton = UIButton()
    private var shadowLayer: CAShapeLayer?
    
    //MARK: Delegate
    var delegate: JEWPopupMessageDelegate?
    
    
    public init() {
        if let topViewController =  UIViewController.top, topViewController.className != self.parentViewController.className  {
            hasAddedSubview = false
            self.parentViewController = topViewController
        }
        popupWidth = popupLayout.width()
        super.init(frame: CGRect.init(x: (parentViewController.view.frame.width - popupLayout.width())/2, y: popupLayout.hidePosition(popupHeight: popupHeight), width: popupWidth, height: popupHeight))
        
    }
    
    public init(parentViewController:UIViewController) {
        if parentViewController.className != self.parentViewController.className {
            hasAddedSubview = false
        }
        self.parentViewController = parentViewController
        popupWidth = popupLayout.width()
        super.init(frame: CGRect.init(x: (parentViewController.view.frame.width - popupLayout.width())/2, y: popupLayout.hidePosition(popupHeight: popupHeight), width: popupWidth, height: popupHeight))
        
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        popupWidth = popupLayout.width()
        self.frame.size.width = popupWidth
        self.frame.origin.x = (parentViewController.view.frame.width - popupLayout.width())/2
        
        UIView.animate(withDuration: 1) {
            self.round(corners: self.popupLayout.roundCorners(), radius: self.popupLayout.cornerRadius(), backgroundColor: self.popupBackgroundColor, withShadow: true)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show(withTextMessage message:String, title:String = "", popupType: JEWPopupMessageType = .error, shouldHideAutomatically: Bool = true, sender: UIView? = nil) {
        setup(withTextMessage: message, title: title, popupType: popupType, shouldHideAutomatically: shouldHideAutomatically)
        show()
    }
    
    public func setup(withTextMessage message:String, title:String = "", popupType: JEWPopupMessageType = .error, shouldHideAutomatically: Bool = true) {
        if let shadowLayer = self.shadowLayer {
            shadowLayer.removeFromSuperlayer()
        }
        self.shadowLayer = nil
        
        self.shouldHideAutomatically = shouldHideAutomatically
        self.popupType = popupType
        messageColor = self.popupType.messageColor()
        popupBackgroundColor = self.popupType.backgroundColor()
        setupMessageAttributed(withTextMessage: message, title: title)
        setupUI()
        calculateHeightOfPopup()
    }
    
    public func show() {
        if hasAddedSubview == false {
            UIApplication.shared.keyWindow?.addSubview(self)
            hasAddedSubview = true
            setupView()
            
        }
        showPopup()
    }
    
    private func setupMessageAttributed(withTextMessage message:String, title:String) {
        messageAttributed = NSMutableAttributedString()
        let titleAttributed = NSAttributedString.init(string: title, attributes: [NSAttributedString.Key.font : UIFont.JEW16Bold()])
        let textMessageAttributed = NSAttributedString.init(string: message, attributes: [NSAttributedString.Key.font : UIFont.JEW14()])
        messageAttributed.append(titleAttributed)
        messageAttributed.append(textMessageAttributed)
        
    }
    
    private func setupUI() {
        textMessageLabel.attributedText = messageAttributed
        textMessageLabel.textColor = messageColor
        
        if let closeImage = UIImage.init(named: JEWConstants.Resources.Images.closeIconWhite.rawValue, in: Bundle(for: type(of: self)), compatibleWith: nil) {
            closeButton.tintColor = messageColor
            closeButton.setImage(closeImage, for: .normal)
        } else {
            closeButton.setTitleColor(messageColor, for: .normal)
            let closeTitle = NSAttributedString.init(string: "X", attributes: [NSAttributedString.Key.font : UIFont.JEW14(),NSAttributedString.Key.foregroundColor:messageColor])
            closeButton.setAttributedTitle(closeTitle, for: .normal)
        }
        if shadowLayer != nil {
            shadowLayer?.fillColor = popupBackgroundColor.cgColor
        }
    }
    
    private func calculateHeightOfPopup() {
        let paddings: CGFloat = 24
        let buttonWidth: CGFloat = 30
        popupWidth = popupLayout.width()
        let textMessageWidth = popupWidth - paddings - buttonWidth
        let estimatedPopupHeight = messageAttributed.string.height(withConstrainedWidth: textMessageWidth, font: .JEW16Bold())
        popupHeight = popupLayout.defaultHeight()
        if estimatedPopupHeight > popupHeight {
            popupHeight = estimatedPopupHeight
        }
    }
    
    private func showPopup() {
        self.alpha = 1
        heightLabelConstraint.constant = self.popupHeight * 0.95
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: .curveEaseOut, animations: {
            self.frame.size.height = self.popupHeight
            self.frame.origin.y = self.popupLayout.showPosition(popupHeight: self.popupHeight)
        }) { (finished) in
            if self.shouldHideAutomatically {
                self.timerToHide = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(JEWPopupMessage.hide), userInfo: nil, repeats: false)
            }
        }
    }
    
    @objc func hide() {
        self.timerToHide.invalidate()
        UIView.animate(withDuration: 0.4, animations: {
            UIView.animate(withDuration: 0.4) {
                self.frame.origin.y = self.popupLayout.hidePosition(popupHeight: self.popupHeight)
                self.alpha = 0
            }
        }) { (finished) in
            self.delegate?.didFinishDismissPopupMessage(withPopupMessage: self)
        }
    }
}

extension JEWPopupMessage: JEWCodeView {
    public func buildViewHierarchy() {
        self.addSubview(textMessageLabel)
        self.addSubview(closeButton)
        textMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func setupConstraints() {
        heightLabelConstraint = textMessageLabel.heightAnchor.constraint(equalToConstant: popupHeight * 0.95)
        NSLayoutConstraint.activate([
            textMessageLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            heightLabelConstraint,
            textMessageLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: textMessageLabel.trailingAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            closeButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        closeButton.addTarget(self, action: #selector(JEWPopupMessage.hide), for: .touchUpInside)
        textMessageLabel.textColor = messageColor
        textMessageLabel.textAlignment = .left
        textMessageLabel.numberOfLines = 0
    }
    
}


public class JEWPopupMessageFactory: JEWPopupMessageDelegate {
    public static let factory = JEWPopupMessageFactory()
    public var popups = [JEWPopupMessage]()
    
    public func showPopups() {
        if let popup = popups.first {
            popup.delegate = self
            popup.show()
        }
    }
    
    
    public func didFinishDismissPopupMessage(withPopupMessage popupMessage: JEWPopupMessage) {
        JEWPopupMessageFactory.factory.popups.removeFirst()
        showPopups()
    }
}
