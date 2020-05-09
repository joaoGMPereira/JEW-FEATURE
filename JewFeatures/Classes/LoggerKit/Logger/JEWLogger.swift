//
//  JEWLogger.swift
//  JewFeatures
//
//  Created by Joao Gabriel Medeiros Perei on 24/11/19.
//

import Foundation

public struct JEWLogger {
    public static func info(_ data: Any, customInfo: String = "ℹ") {
        if JEWSession.session.services.isDev() {
                print("\n\n-----------\(customInfo)-----------\n\n\(data)\n\n-----------\(customInfo)-----------\n\n")
                return
        }
    }
    
    public static func warning(_ data: Any) {
        if JEWSession.session.services.isDev() {
            print("\n\n-----------⚠-----------\n\n\(data)\n\n-----------⚠-----------\n\n")
            return
        }
    }
    
    public static func error(_ data: Any) {
        if JEWSession.session.services.isDev() {
            print("\n\n-----------🛑-----------\n\n\(data)\n\n-----------🛑-----------\n\n")
            return
        }
    }
}
