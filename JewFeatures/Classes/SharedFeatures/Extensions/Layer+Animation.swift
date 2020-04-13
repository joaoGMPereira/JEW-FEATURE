//
//  Layer+Animation.swift
//  JewFeatures
//
//  Created by Joao Gabriel Medeiros Perei on 09/12/19.
//

import Foundation
import UIKit
public typealias FinishAnimation = (() -> Void)
extension CALayer {
    
    func addShadow() {
           self.shadowOffset = CGSize(width: 0, height: 1)
           self.shadowOpacity = 0.2
           self.shadowRadius = 1
           self.shadowColor = UIColor.black.cgColor
           self.masksToBounds = false
           
           if cornerRadius != 0 {
               addShadowWithRoundedCorners()
           }
       }
       
       func roundCorners(radius: CGFloat) {
           self.cornerRadius = radius
           
           if shadowOpacity != 0 {
               addShadowWithRoundedCorners()
           }
       }
       
       private func addShadowWithRoundedCorners() {
           if let contents = self.contents {
               
               let customLayerName = "customLayer"
               
               masksToBounds = false
               sublayers?.filter { $0.frame.equalTo(self.bounds) }
                   .forEach { $0.roundCorners(radius: self.cornerRadius) }
               
               self.contents = nil
               
               if let sublayer = sublayers?.first, sublayer.name == customLayerName {
                   sublayer.removeFromSuperlayer()
               }
               
               let contentLayer = CALayer()
               contentLayer.name = customLayerName
               contentLayer.contents = contents
               contentLayer.frame = bounds
               contentLayer.cornerRadius = cornerRadius
               contentLayer.masksToBounds = true
               
               insertSublayer(contentLayer, at: 0)
           }
       }
    
    public func animate(width: CGFloat = 1.03, height: CGFloat = 1.03, finish: FinishAnimation? = nil) {
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
