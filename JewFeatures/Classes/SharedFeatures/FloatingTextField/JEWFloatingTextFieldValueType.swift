//
//  JEWFloatingTextFieldValueType.swift
//  InvestEx_Example
//
//  Created by Joao Medeiros Pereira on 12/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

public enum JEWFloatingTextFieldValueType {
    
    case none
    case currency
    case months
    case percent
    case maxSize(size: Int)
    
    
    public func formatText(textFieldText: String, isBackSpace: Bool = false) -> String {
        switch self {
        case .none:
            return textFieldText
        case .currency:
            return textFieldText.currencyFormat(backSpace: isBackSpace)
        case .months:
            return textFieldText.monthFormat()
        case .percent:
            return textFieldText.percentFormat(backSpace: isBackSpace)
        case .maxSize(let size):
            return textFieldText.stringOfNumbersRegex(with: size)
        }
    }
}
