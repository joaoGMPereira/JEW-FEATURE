//
//  Double+INVSExtension.swift
//  InvestScopio_Example
//
//  Created by Joao Medeiros Pereira on 14/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    public func INVSrounded(toPlaces places:Int = 4) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    public func currencyFormat(withSize size: Int? = nil) -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter.currencyDefault()
        
        var amountWithoutPrefix = String(format: "%.2f", self)
        
        // remove from String: "$", ".", ","
        amountWithoutPrefix = amountWithoutPrefix.stringOfNumbersRegex(with: size)
        
        let double = (amountWithoutPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
//        guard number != 0 as NSNumber else {
//            return "0"
//        }
        return formatter.string(from: number) ?? String()
    }
}
