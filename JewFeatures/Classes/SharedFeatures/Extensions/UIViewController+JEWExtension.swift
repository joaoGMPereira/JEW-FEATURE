//
//  UIViewController+.swift
//  InvestScopio_Example
//
//  Created by Joao Medeiros Pereira on 17/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public static func toString() -> String {
        return String(describing: self.self)
    }
    
    public var background: UIColor? {
        set {
            view.backgroundColor = newValue
        }
        get {
            return view.backgroundColor
        }
    }
}

