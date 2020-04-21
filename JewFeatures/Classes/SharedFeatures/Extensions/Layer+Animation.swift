//
//  Layer+Animation.swift
//  JewFeatures
//
//  Created by Joao Gabriel Medeiros Perei on 09/12/19.
//

import Foundation
import UIKit
public typealias FinishAnimation = (() -> Void)
public extension CALayer {
    func animate(width: CGFloat = 1.03, height: CGFloat = 1.03, finish: FinishAnimation? = nil) {
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CATransform3DMakeScale(width, height, 1.0)
        }) { (finished) in
            UIView.animate(withDuration: 0.3, animations: {
                self.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
            }) { (finished) in
                if let finish = finish {
                    finish()
                }
                
            }
        }
    }
}
