//
//  JEWFloatingTextFieldValueType.swift
//  InvestEx_Example
//
//  Created by Joao Medeiros Pereira on 12/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

public enum JEWFloatingTextFieldValueType: Decodable, Comparable {
    public static func < (lhs: JEWFloatingTextFieldValueType, rhs: JEWFloatingTextFieldValueType) -> Bool {
        return lhs != rhs
    }
    
    case none
    case currency
    case months
    case percent
    case maxSize(size: Int)
    
    enum CodingKeys: Int, CodingKey {
      case none, currency, months, percent, maxSize
    }
    
    public init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
        if (try container.decodeIfPresent(Int.self, forKey: .none)) != nil {
        self = .none
        } else if (try container.decodeIfPresent(Int.self, forKey: .currency)) != nil {
        self = .currency
        } else if (try container.decodeIfPresent(Int.self, forKey: .months)) != nil {
        self = .months
        } else if (try container.decodeIfPresent(Int.self, forKey: .percent)) != nil {
        self = .percent
      } else {
        self = .maxSize(size: try container.decode(Int.self, forKey: .maxSize))
      }
    }
    
    
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
