//
//  JEWConnectorStructs.swift
//  Alamofire
//
//  Created by Joao Gabriel Medeiros Perei on 22/11/19.
//

import UIKit

public enum ConnectorRoutes {
    case signup
    case signin
    case logout
    case refreshToken

    public func getRoute() -> URL? {
        switch self {
        case .signup:
            return JEWConnector.getURL(withRoute: JEWConstants.Services.signUp.rawValue)
        case .signin:
            return JEWConnector.getURL(withRoute: JEWConstants.Services.signIn.rawValue)
        case .logout:
            return JEWConnector.getURL(withRoute: JEWConstants.Services.logout.rawValue)
        case .refreshToken:
            return JEWConnector.getURL(withRoute: JEWConstants.Services.refreshToken.rawValue)
        }
    }
}

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
    var error: ConnectorErrorType
    var title: String
    let message: String
    let shouldRetry: Bool
    
    
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
