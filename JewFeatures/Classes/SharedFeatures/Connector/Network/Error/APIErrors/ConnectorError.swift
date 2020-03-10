//
//  LifeSupportPreLoginError.swift
//  LifeSupport
//
//  Created by Joao Gabriel Medeiros Perei on 30/01/20.
//

import Foundation

public enum ConnectorError {
    case knownApiFailures(error: Enums.KnownApiFailures)
    case knownApiInformalFailures(error: Enums.KnownApiInformalFailures)
    case knownApiRedirections(error: Enums.KnownApiRedirections)
    case knownApiClientErrors(error: Enums.KnownApiClientErrors)
    case knownApiServerErrors(error: Enums.KnownApiServerErrors)
    case parserError(error: Enums.ParserError)
    public class Enums {
        
        public enum KnownApiFailures: Error {
            case invalidParams(Error)
            case failure(Error)
            case invalidResponse(Error)
            case clientOrServerError(Error)
            case nonDataClientOrServerError(Error)
            case noFlowErrorCode(Error)
            case noInternetErrorCode(Error)
            case requestTimeout(Error)
            case requestFailedForbidden(Error)
            case emptySecurityData(Error)
            case idleSessionTimeout(Error)
            case sessionTimeout(Error)
            case sdkTimeout(Error)
        }
        
        public enum KnownApiInformalFailures: Error {
            case `continue`(Error)
            case switchingProtocols(Error)
            case processing(Error)
        }
        
        public enum KnownApiRedirections: Error {
            case multipleChoices(Error)
            case movedPermanently(Error)
            case found(Error)
            case seeOther(Error)
            case notModified(Error)
            case useProxy(Error)
            case temporaryRedirect(Error)
            case permanentRedirect(Error)
        }
        
        public enum KnownApiClientErrors: Error {
            case badRequest(Error)
            case unauthorized(Error)
            case paymentRequired(Error)
            case forbidden(Error)
            case notFound(Error)
            case methodNotAllowed(Error)
            case notAcceptable(Error)
            case proxyAuthenticationRequired(Error)
            case requestTimeout(Error)
            case conflict(Error)
            case gone(Error)
            case lengthRequired(Error)
            case preconditionFailed(Error)
            case payloadTooLarge(Error)
            case requestURITooLong(Error)
            case unsupportedMediaType(Error)
            case requestedRangeNotSatisfiable(Error)
            case expectationFailed(Error)
            case imTeapot(Error)
            case misdirectedRequest(Error)
            case unprocessableEntity(Error)
            case locked(Error)
            case failedDependency(Error)
            case upgradeRequired(Error)
            case preconditionRequired(Error)
            case tooManyRequests(Error)
            case requestHeaderFieldsTooLarge(Error)
            case connectionClosedWithoutResponse(Error)
            case unavailableForLegalReasons(Error)
            case clientClosedRequest(Error)
        }
        
        public enum KnownApiServerErrors: Error {
            case internalServerError(Error)
            case notImplemented(Error)
            case badGateway(Error)
            case serviceUnavailable(Error)
            case gatewayTimeout(Error)
            case httpVersionNotSupported(Error)
            case variantAlsoNegotiates(Error)
            case insufficientStorage(Error)
            case loopDetected(Error)
            case notExtended(Error)
            case networkAuthenticationRequired(Error)
            case networkConnectTimeoutError(Error)
        }
        
        public enum ParserError:Error {
            case parserError(Error)
            case failedToParser(Error)
        }
    }
    
    /// Tratamento de erros da api
    ///
    /// - Parameters:
    ///   - error: erro da api
    ///   - statusCode: código de status
    /// - Throws: erros da api
    public static func handleError(error: Error?) -> ConnectorError {
        guard let error = error else {
            return .knownApiFailures(error: .failure(ConnectorError.customError(domain: "NoError", localizedDescription: "No API Error")))
        }
        
        switch error._code {
        case 100...199:
            return LifeSupportErrorHandler.handleAPIInformalError(error: error)
        case 300...399:
            return LifeSupportErrorHandler.handleAPIRedirectionsError(error: error)
        case 400...499:
            return LifeSupportErrorHandler.handleAPIClientError(error: error)
        case 500...599:
            return LifeSupportErrorHandler.handleAPIServerError(error: error)
        case 907...908:
            return LifeSupportErrorHandler.handleAPIParserError(error: error)
        default:
            return LifeSupportErrorHandler.handleAPIError(error: error)
        }
    }
    
    public static func customError(domain: String = "TestError", code: Int = 999, localizedDescription: String = "TestError") -> Error {
        return NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
}
