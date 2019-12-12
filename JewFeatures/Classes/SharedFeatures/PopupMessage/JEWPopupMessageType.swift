//
//  JEWPopupMessageType.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 21/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
public enum JEWPopupMessageType {
    
    case error
    case alert
    case custom(messageColor: UIColor, backgroundColor: UIColor)
    
    public func messageColor() -> UIColor {
        switch self {
        case .error:
            return .white
        case .alert:
            return .white
        case .custom(let messageColor, _):
            return messageColor
        }
    }
    
    public func backgroundColor() -> UIColor {
        switch self {
        case .error:
            return .JEWRed()
        case .alert:
            return .JEWDefault()
        case .custom(_, let backgroundColor):
            return backgroundColor
        }
    }
}
