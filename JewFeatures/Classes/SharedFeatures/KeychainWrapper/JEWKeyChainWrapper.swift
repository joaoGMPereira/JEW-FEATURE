//
//  KeychainWrapper.swift
//  InvestScopio_Example
//
//  Created by Joao Medeiros Pereira on 14/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class JEWKeyChainWrapper: NSObject {
    static let uniqueServiceName = "com.br.joao.gabriel.medeiros.pereira.InvestScopio"
    static let instance : KeychainWrapper = {
        return KeychainWrapper(serviceName: uniqueServiceName)
    }()
    
    @discardableResult static func save(withValue value:String, andKey key: String) -> Bool {
        let saveSuccessful: Bool = JEWKeyChainWrapper.instance.set(value, forKey: key)
        return saveSuccessful
    }
    
    @discardableResult static func update(withValue value:String, andKey key: String) -> Bool {
        let _: Bool = JEWKeyChainWrapper.instance.removeObject(forKey: key)
        let updateSuccessful: Bool = JEWKeyChainWrapper.instance.set(value, forKey: key)
        return updateSuccessful
    }
    
    @discardableResult static func retrieve(withKey key: String) -> String? {
        let retrievedString: String? = JEWKeyChainWrapper.instance.string(forKey: key)
        return retrievedString
    }
    
    @discardableResult static func saveDouble(withValue value:Double, andKey key: String) -> Bool {
        let saveSuccessful: Bool = JEWKeyChainWrapper.instance.set(value, forKey: key)
        return saveSuccessful
    }
    
    @discardableResult static func updateDouble(withValue value:Double, andKey key: String) -> Bool {
        let _: Bool = JEWKeyChainWrapper.instance.removeObject(forKey: key)
        let updateSuccessful: Bool = JEWKeyChainWrapper.instance.set(value, forKey: key)
        return updateSuccessful
    }
    
    @discardableResult static func retrieveDouble(withKey key: String) -> Double? {
        let retrievedDouble: Double? = JEWKeyChainWrapper.instance.double(forKey: key)
        return retrievedDouble
    }
    
    @discardableResult static func saveBool(withValue value:Bool, andKey key: String) -> Bool {
        let saveSuccessful: Bool = JEWKeyChainWrapper.instance.set(value, forKey: key)
        return saveSuccessful
    }
    
    @discardableResult static func updateBool(withValue value:Bool, andKey key: String) -> Bool {
        let _: Bool = JEWKeyChainWrapper.instance.removeObject(forKey: key)
        let updateSuccessful: Bool = JEWKeyChainWrapper.instance.set(value, forKey: key)
        return updateSuccessful
    }
    
    @discardableResult static func retrieveBool(withKey key: String) -> Bool? {
        let retrievedBool: Bool? = JEWKeyChainWrapper.instance.bool(forKey: key)
        return retrievedBool
    }
    
    //MARK: Remove any kind of object
    @discardableResult static func remove(withKey key: String) -> Bool {
        let removeSuccessful: Bool = JEWKeyChainWrapper.instance.removeObject(forKey: key)
        return removeSuccessful
    }
    
    static func clear() {
        JEWKeyChainWrapper.instance.removeAllKeys()
    }
}
