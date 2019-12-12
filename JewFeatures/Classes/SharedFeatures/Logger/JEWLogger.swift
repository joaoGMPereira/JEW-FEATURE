//
//  JEWLogger.swift
//  JewFeatures
//
//  Created by Joao Gabriel Medeiros Perei on 24/11/19.
//

import Foundation

public struct JEWLogger {
    public static func info(_ text: String) {
        if JEWSession.session.isDev() {
            print("ℹ \(text)")
        }
    }
    
    public static func warning(_ text: String) {
        if JEWSession.session.isDev() {
            print("⚠ \(text)")
        }
    }
    
    public static func error(_ text: String) {
       if JEWSession.session.isDev() {
            print("🛑 \(text)")
        }
    }
}
