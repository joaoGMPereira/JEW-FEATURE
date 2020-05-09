//
//  NumberFormatter+INVSExtension.swift
//  InvestEx_Example
//
//  Created by Joao Medeiros Pereira on 12/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

extension NumberFormatter {
    public static func currencyDefault() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.locale = Locale.init(identifier: "pt_BR")
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }
}
