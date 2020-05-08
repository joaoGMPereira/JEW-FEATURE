//
//  NSUserDefaults+Codable.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 07/05/20.
//

import Foundation


public extension Encodable {
    func saveInDefaults(in key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }
    
    func removeInDefaults(in key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
    }
}
