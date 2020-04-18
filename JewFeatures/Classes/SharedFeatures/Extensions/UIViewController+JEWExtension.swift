//
//  UIViewController+.swift
//  InvestScopio_Example
//
//  Created by Joao Medeiros Pereira on 17/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    static func toString() -> String {
        return String(describing: self.self)
    }
    
    var background: UIColor? {
        set {
            view.backgroundColor = newValue
        }
        get {
            return view.backgroundColor
        }
    }
    
    static var top: UIViewController? {
          get {
              return topViewController()
          }
      }
      
      static var root: UIViewController? {
          get {
              return UIApplication.shared.delegate?.window??.rootViewController
          }
      }
      
      static func topViewController(from viewController: UIViewController? = UIViewController.root) -> UIViewController? {
          if let tabBarViewController = viewController as? UITabBarController {
              return topViewController(from: tabBarViewController.selectedViewController)
          } else if let navigationController = viewController as? UINavigationController {
              return topViewController(from: navigationController.visibleViewController)
          } else if let presentedViewController = viewController?.presentedViewController {
              return topViewController(from: presentedViewController)
          } else {
              return viewController
          }
      }
}

