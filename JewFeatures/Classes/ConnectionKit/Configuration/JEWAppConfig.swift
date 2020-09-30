//
//  JEWConfiguration.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 30/09/20.
//

import Foundation

public enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }

        if let string = object as? String, let generic = T(string.replacingOccurrences(of: "\"", with: "")) {
            return generic
        }
        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

public enum Scheme:String, CaseIterable {
    case Debug
    case Release
    case Local
    public static var scheme: Scheme {
        do {
            return try Scheme.init(rawValue: Configuration.value(for: "APPScheme")) ?? .Release
        } catch {
            return .Release
        }
    }
    
    public static func setupConfig(prodURL: String, debugURL: String) {
        setUniqueServiceName()
        setBaseURL(prodURL: prodURL, debugURL: debugURL)
    }
    
    static func setUniqueServiceName() {
        do {
            JEWKeyChainWrapperServiceName.instance.uniqueServiceName = try Configuration.value(for: "CFBundleIdentifier")
        } catch {
            JEWKeyChainWrapperServiceName.instance.uniqueServiceName = "com.br.joao.gabriel.medeiros.pereira.JEWApps"
        }
    }
    static func setBaseURL(prodURL: String, debugURL: String) {
        var baseURL = prodURL
        if Scheme.scheme == .Debug {
            switch JEWSession.session.services.scheme {
            case .Local:
                baseURL = JEWConstants.Services.localHost.rawValue
            case .Debug:
                baseURL = debugURL
            case .Release:
                baseURL = prodURL
            }
            
        }
        
        JEWConnector.connector.baseURL = baseURL
    }
}
