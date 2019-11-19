//
//  UIView+INVSExtension.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 13/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    func addBlur(withBlurEffectStyle style: UIBlurEffect.Style = .dark) {
        let darkBlur = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = self.bounds
        self.addSubview(blurView)
    }
}
