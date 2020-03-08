//
//  JEWConnectorStructs.swift
//  Alamofire
//
//  Created by Joao Gabriel Medeiros Perei on 22/11/19.
//

import UIKit


public enum ConnectorErrorType: Int {
    case none
    case authentication
    case settings
    case expiredSession
    case logout
    
}

public struct ConnectorConstants {
    public static func defaultErrorTitle() -> String {
        return JEWConstants.Default.title.rawValue
    }
    
    public static func defaultErrorMessage() -> String {
        return JEWConstants.Default.errorMessage.rawValue
    }
}

public struct ConnectorError {
    public var error: ConnectorErrorType
    public var title: String
    public let message: String
    public let shouldRetry: Bool
    
    
    init(error: ConnectorErrorType = .none, title: String = ConnectorConstants.defaultErrorTitle(), message: String = ConnectorConstants.defaultErrorMessage(), shouldRetry: Bool = false) {
        self.error = error
        self.title = title
        self.message = message
        self.shouldRetry = shouldRetry
    }
}

public struct ApiError: Decodable {
    var error: Bool = true
    let reason: String
    public static func `default`() -> ApiError {
        return ApiError(error: true, reason: ConnectorConstants.defaultErrorMessage())
    }
}
