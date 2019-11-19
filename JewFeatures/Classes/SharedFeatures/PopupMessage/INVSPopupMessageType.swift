//
//  INVSPopupMessageType.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 21/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
enum INVSPopupMessageType: Int {
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
            return .INVSRed()
        case .alert:
            return .INVSDefault()
        }
    }
}
