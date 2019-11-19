//
//  JEWPopupMessageType.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 21/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
enum JEWPopupMessageType: Int {
    case error = 0
    case alert
    
    func messageColor() -> UIColor {
        switch self {
        case .error:
            return .white
        case .alert:
            return .white
        }
    }
    
    func backgroundColor() -> UIColor {
        switch self {
        case .error:
            return .JEWRed()
        case .alert:
            return .JEWDefault()
        }
    }
}
