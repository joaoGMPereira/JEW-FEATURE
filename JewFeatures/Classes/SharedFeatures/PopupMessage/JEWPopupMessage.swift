//
//  JEWPopupMessage.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 13/05/19.
//

import Foundation
import UIKit

protocol JEWPopupMessageDelegate {
    func didFinishDismissPopupMessage(withPopupMessage popupMessage:JEWPopupMessage)
}

class JEWPopupMessage: UIView {
    
    private let defaultHeight = CGFloat(60)
    private var size = CGSize()
    private var hasAddedSubview = false
    private var topBarHeight = CGFloat(0.0)
    private var topConstraint = NSLayoutConstraint()
    private var popupHeight = CGFloat(60.0)
    private var popupWidth = CGFloat(200)
    private var shadowLayer: CAShapeLayer?
    private var timerToHide = Timer()
    private var messageColor: UIColor = JEWPopupMessageType.error.messageColor()
    private var popupBackgroundColor: UIColor = JEWPopupMessageType.error.backgroundColor()
    private var heightLabelConstraint = NSLayoutConstraint()
    private var parentViewController = UIViewController()
    private var sender: UIView?
    private var shouldHideAutomatically = true
    private var messageAttributed = NSMutableAttributedString()
    var textMessageLabel = UILabel()
    var closeButton = UIButton()
    var delegate: JEWPopupMessageDelegate?
    var popupType: JEWPopupMessageType = .alert
    
    
    init(parentViewController:UIViewController) {
        self.parentViewController = parentViewController
        let topPadding = CGFloat(10)
        popupWidth = parentViewController.view.frame.width * 0.9
        topBarHeight = UIApplication.shared.statusBarFrame.size.height + topPadding
        super.init(frame: CGRect.init(x: (parentViewController.view.frame.width - (parentViewController.view.frame.width * 0.9))/2, y: -(topBarHeight+popupHeight), width: popupWidth, height: popupHeight))
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        popupWidth = parentViewController.view.frame.width * 0.9
        self.frame.size.width = popupWidth
        self.frame.origin.x = (parentViewController.view.frame.width - (parentViewController.view.frame.width * 0.9))/2
        
        UIView.animate(withDuration: 1) {
            self.shadowLayer = CAShapeLayer.addCorner(withShapeLayer: self.shadowLayer, withCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], withRoundedCorner: 12, andColor: self.popupBackgroundColor, inView: self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(withTextMessage message:String, title:String = "", popupType: JEWPopupMessageType = .error, shouldHideAutomatically: Bool = true, sender: UIView? = nil) {
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
        if hasAddedSubview == false {
            UIApplication.shared.keyWindow?.addSubview(self)
            hasAddedSubview = true
            setupView()
            
        }
        showPopup(sender: sender)
    }
    
    func show(withAttributedMessage message:String, title:String = "", popupType: JEWPopupMessageType = .error, shouldHideAutomatically: Bool = true, sender: UIView? = nil) {
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
        if hasAddedSubview == false {
            UIApplication.shared.keyWindow?.addSubview(self)
            hasAddedSubview = true
            setupView()
        }
        showPopup(sender: sender)
    }
    
    private func setupMessageAttributed(withTextMessage message:String, title:String) {
        messageAttributed = NSMutableAttributedString()
        let titleAttributed = NSAttributedString.init(string: title, attributes: [NSAttributedString.Key.font : UIFont.JEWFontBigBold()])
        let textMessageAttributed = NSAttributedString.init(string: message, attributes: [NSAttributedString.Key.font : UIFont.JEWFontDefault()])
        messageAttributed.append(titleAttributed)
        messageAttributed.append(textMessageAttributed)
        
    }
    
    private func setupUI() {
        textMessageLabel.attributedText = messageAttributed
        textMessageLabel.textColor = messageColor
        if let closeImage = UIImage.init(named: "closeIconWhite") {
            closeButton.tintColor = messageColor
            closeButton.setImage(closeImage, for: .normal)
        } else {
            closeButton.setTitleColor(messageColor, for: .normal)
            let closeTitle = NSAttributedString.init(string: "X", attributes: [NSAttributedString.Key.font : UIFont.JEWFontDefault(),NSAttributedString.Key.foregroundColor:messageColor])
            closeButton.setAttributedTitle(closeTitle, for: .normal)
        }
        if shadowLayer != nil {
            shadowLayer?.fillColor = popupBackgroundColor.cgColor
        }
    }
    
    private func calculateHeightOfPopup() {
        let paddings: CGFloat = 24
        let buttonWidth: CGFloat = 30
        popupWidth = parentViewController.view.frame.width * 0.9
        let textMessageWidth = popupWidth - paddings - buttonWidth
        let estimatedPopupHeight = messageAttributed.string.height(withConstrainedWidth: textMessageWidth, font: .JEWFontBigBold())
        popupHeight = defaultHeight
        if estimatedPopupHeight > defaultHeight {
            popupHeight = estimatedPopupHeight
        }
    }
    
    private func showPopup(sender: UIView?) {
        self.alpha = 1
        heightLabelConstraint.constant = self.popupHeight * 0.95
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: .curveEaseOut, animations: {
            self.frame.size.height = self.popupHeight
            self.frame.origin.y = self.topBarHeight
            self.sender = sender
            if let sender = sender {
                self.frame.origin.y = sender.superview?.convert(CGPoint.init(x: 0, y: sender.frame.minY), to: self.superview).y ?? self.topBarHeight
            }

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
                let topBarHeight = UIApplication.shared.statusBarFrame.size.height + (self.parentViewController.navigationController?.navigationBar.frame.height ?? 0.0)
                self.frame.origin.y = -(topBarHeight + self.popupHeight)
                self.alpha = 0
            }
        }) { (finished) in
            self.delegate?.didFinishDismissPopupMessage(withPopupMessage: self)
        }
    }
}

extension JEWPopupMessage: JEWCodeView {
    func buildViewHierarchy() {
        self.addSubview(textMessageLabel)
        self.addSubview(closeButton)
        textMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        heightLabelConstraint = textMessageLabel.heightAnchor.constraint(equalToConstant: popupHeight * 0.95)
        NSLayoutConstraint.activate([
            textMessageLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            heightLabelConstraint,
            textMessageLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 0)
            ])
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: textMessageLabel.trailingAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
            ])
    }
    
    func setupAdditionalConfiguration() {
        closeButton.addTarget(self, action: #selector(JEWPopupMessage.hide), for: .touchUpInside)
        textMessageLabel.textColor = messageColor
        textMessageLabel.textAlignment = .left
        textMessageLabel.numberOfLines = 0
    }
    
}
