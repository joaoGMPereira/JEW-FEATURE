//
//  UIButton+INVSExtension.swift
//  InvestScopio_Example
//
//  Created by Joao Medeiros Pereira on 19/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    open override var isEnabled: Bool{
        didSet {
            UIView.animate(withDuration: 1.2, animations: {
                self.alpha = self.isEnabled ? 1.0 : 0.7
            })
        }
    }
    
}
