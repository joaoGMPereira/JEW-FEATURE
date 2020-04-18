//
//  JEWRecheability.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 18/04/20.
//

import Foundation
import Alamofire
public class JEWReachability {
    // Can't init is singleton
    
    public static let recheability = JEWReachability()
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
    
    @objc public func check() {
        if let isReachable = NetworkReachabilityManager()?.isReachable {
            isReachable ? isConnected() : isDisconnect()
        }
    }
    
    func isConnected() {
        popupView?.hide()
    }
    
    func isDisconnect() {
        checkViewController()
        popupView?.show(withTextMessage: "Verifique sua conexão com a internet.", title: "Você está desconectado!\n", popupType: .error, shouldHideAutomatically: false, sender: nil)
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
