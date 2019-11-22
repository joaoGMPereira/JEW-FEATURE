//
//  JEWPopupMessageType.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 21/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
public enum JEWPopupMessageType: Int {
    case error = 0
    case alert
    
    public func messageColor() -> UIColor {
        switch self {
        case .error:
            return .white
        case .alert:
            return .white
        }
    }
    
    public func backgroundColor() -> UIColor {
        switch self {
        case .error:
            return .JEWRed()
        case .alert:
            return .JEWDefault()
        }
    }
}
