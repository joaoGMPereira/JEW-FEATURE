//
//  KeychainWrapper.swift
//  InvestScopio_Example
//
//  Created by Joao Medeiros Pereira on 14/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

public class JEWKeyChainWrapperServiceName: NSObject {
    public var uniqueServiceName = ""
    public static let instance: JEWKeyChainWrapperServiceName = {
        return JEWKeyChainWrapperServiceName()
    }()
    
}

public class JEWKeyChainWrapper: NSObject {
    public static let instance : KeychainWrapper = {
        return KeychainWrapper(serviceName: JEWKeyChainWrapperServiceName.instance.uniqueServiceName)
    }()
    
    @discardableResult public static func save(withValue value:String, andKey key: String) -> Bool {
        let saveSuccessful: Bool = JEWKeyChainWrapper.instance.set(value, forKey: key)
        return saveSuccessful
    }
    
    @discardableResult public static func update(withValue value:String, andKey key: String) -> Bool {
        let _: Bool = JEWKeyChainWrapper.instance.removeObject(forKey: key)
        let updateSuccessful: Bool = JEWKeyChainWrapper.instance.set(value, forKey: key)
        return updateSuccessful
    }
    
    @discardableResult public static func retrieve(withKey key: String) -> String? {
        let retrievedString: String? = JEWKeyChainWrapper.instance.string(forKey: key)
        return retrievedString
    }
    
    @discardableResult public static func saveDouble(withValue value:Double, andKey key: String) -> Bool {
        let saveSuccessful: Bool = JEWKeyChainWrapper.instance.set(value, forKey: key)
        return saveSuccessful
    }
    
    @discardableResult public static func updateDouble(withValue value:Double, andKey key: String) -> Bool {
        let _: Bool = JEWKeyChainWrapper.instance.removeObject(forKey: key)
        let updateSuccessful: Bool = JEWKeyChainWrapper.instance.set(value, forKey: key)
        return updateSuccessful
    }
    
    @discardableResult public static func retrieveDouble(withKey key: String) -> Double? {
        let retrievedDouble: Double? = JEWKeyChainWrapper.instance.double(forKey: key)
        return retrievedDouble
    }
    
    @discardableResult public static func saveBool(withValue value:Bool, andKey key: String) -> Bool {
        let saveSuccessful: Bool = JEWKeyChainWrapper.instance.set(value, forKey: key)
        return saveSuccessful
    }
    
    @discardableResult public static func updateBool(withValue value:Bool, andKey key: String) -> Bool {
        let _: Bool = JEWKeyChainWrapper.instance.removeObject(forKey: key)
        let updateSuccessful: Bool = JEWKeyChainWrapper.instance.set(value, forKey: key)
        return updateSuccessful
    }
    
    @discardableResult public static func retrieveBool(withKey key: String) -> Bool? {
        let retrievedBool: Bool? = JEWKeyChainWrapper.instance.bool(forKey: key)
        return retrievedBool
    }
    
    //MARK: Remove any kind of object
    @discardableResult public static func remove(withKey key: String) -> Bool {
        let removeSuccessful: Bool = JEWKeyChainWrapper.instance.removeObject(forKey: key)
        return removeSuccessful
    }
    
    public static func clear() {
        JEWKeyChainWrapper.instance.removeAllKeys()
    }
}
