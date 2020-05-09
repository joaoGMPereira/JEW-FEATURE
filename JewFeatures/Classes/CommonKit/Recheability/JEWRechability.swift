//
//  JEWRecheability.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 18/04/20.
//

import Foundation
import Alamofire

public struct JEWReachabilityConfig {
    public let title: String
    public let message: String
    public let alertType: JEWPopupMessageType
    public let shouldHideAutomatically: Bool
    
    public init(title: String, message: String, alertType: JEWPopupMessageType, shouldHideAutomatically: Bool = false) {
        self.title = title
        self.message = message
        self.alertType = alertType
        self.shouldHideAutomatically = shouldHideAutomatically
    }
}

public class JEWReachability {
    // Can't init is singleton
    
    public static let recheability = JEWReachability()
    public var config: JEWReachabilityConfig?
    var timerToCheck = Timer()
    var popupView: JEWPopupMessage?
    var topViewController: UIViewController?
    
    private init() { }
    public func enable() {
        self.timerToCheck = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(JEWReachability.check), userInfo: nil, repeats: true)
        NetworkReachabilityManager()?.startListening(onQueue: DispatchQueue.main, onUpdatePerforming: { (status) in
            switch status {
            case .unknown:
                self.isDisconnect()
            case .notReachable:
                self.isDisconnect()
            case .reachable(_):
                self.isConnected()
            }
        })
    }
    
    public func disable() {
        self.timerToCheck.invalidate()
        NetworkReachabilityManager()?.stopListening()
    }
    
    @discardableResult @objc public func check() -> Bool {
        if let isReachable = NetworkReachabilityManager()?.isReachable {
            isReachable ? isConnected() : isDisconnect()
            return isReachable
        }
        return false
    }
    
    func isConnected() {
        popupView?.hide()
    }
    
    func isDisconnect() {
        checkViewController()
        popupView?.show(withTextMessage: config?.message ?? "Verifique sua conexão com a internet.", title: config?.title ?? "Você está desconectado!\n", popupType: config?.alertType ?? .error, shouldHideAutomatically: config?.shouldHideAutomatically ?? false)
    }
    
    private func checkViewController() {
        guard let topViewController = topViewController else {
            if let topViewController = UIViewController.topViewController() {
                self.topViewController = topViewController
                popupView = JEWPopupMessage(parentViewController: topViewController)
            }
            return
        }
        if let newTopViewController = UIViewController.topViewController(), topViewController.className != newTopViewController.className {
            self.topViewController = newTopViewController
            popupView = JEWPopupMessage(parentViewController: newTopViewController)
        }
    }
    
}
