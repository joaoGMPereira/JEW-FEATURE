//
//  JEWLogger.swift
//  JewFeatures
//
//  Created by Joao Gabriel Medeiros Perei on 24/11/19.
//

import Foundation

public struct JEWLogger {
    public static func info(_ data: Any, shouldAddPreSufix: Bool = true) {
        if JEWSession.session.services.isDev() {
            if shouldAddPreSufix {
                print("\n\n-----------ℹ-----------\n\n\(data)\n\n-----------ℹ-----------\n\n")
                return
            }
            print(data)
        }
    }
    
    public static func warning(_ data: Any, shouldAddPreSufix: Bool = true) {
        if JEWSession.session.services.isDev() {
            if shouldAddPreSufix {
                print("\n\n-----------⚠-----------\n\n\(data)\n\n-----------⚠-----------\n\n")
                return
            }
            print(data)
        }
    }
    
    public static func error(_ data: Any, shouldAddPreSufix: Bool = true) {
        if JEWSession.session.services.isDev() {
            if shouldAddPreSufix {
                print("\n\n-----------🛑-----------\n\n\(data)\n\n-----------🛑-----------\n\n")
                return
            }
            print(data)
        }
    }
}
