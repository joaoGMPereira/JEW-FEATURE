//
//  LifeSupportErrorHandler.swift
//  LifeSupport
//
//  Created by Joao Gabriel Medeiros Perei on 05/02/20.
//

import Foundation

struct LifeSupportErrorHandler {
    
    static func handleAPIParserError(error: Error) -> ConnectorError {
        if let errorCode = LifeSupportApiParserErrorCode(rawValue: error._code) {
            switch errorCode {
            case .parserError:
                return .parserError(error: .parserError(error))
            case .failedToParser:
                return .parserError(error: .failedToParser(error))
            }
        }
        return .knownApiFailures(error: .failure(error))
    }
    
    static func handleAPIInformalError(error: Error) -> ConnectorError {
        if let errorCode = LifeSupportApiInformalCode(rawValue: error._code) {
            switch errorCode {
            case .continue:
                return .knownApiInformalFailures(error: .continue(error))
            case .switchingProtocols:
                return .knownApiInformalFailures(error: .switchingProtocols(error))
            case .processing:
                return .knownApiInformalFailures(error: .processing(error))
            }
        }
        return .knownApiFailures(error: .failure(error))
    }
    
    static func handleAPISuccess(statusCode: Int) -> LifeSupportApiSuccessCode {
        if let successCode = LifeSupportApiSuccessCode(rawValue: statusCode) {
            return successCode
        }
        return LifeSupportApiSuccessCode.noContent
    }
    
    static func handleAPIRedirectionsError(error: Error) -> ConnectorError {
        if let errorCode = LifeSupportApiRedirectionCode(rawValue: error._code) {
            switch errorCode {
            case .multipleChoices:
                return .knownApiRedirections(error: .multipleChoices(error))
            case .movedPermanently:
                return .knownApiRedirections(error: .movedPermanently(error))
            case .found:
                return .knownApiRedirections(error: .found(error))
            case .seeOther:
                return .knownApiRedirections(error: .seeOther(error))
            case .notModified:
                return .knownApiRedirections(error: .notModified(error))
            case .useProxy:
                return .knownApiRedirections(error: .useProxy(error))
            case .temporaryRedirect:
                return .knownApiRedirections(error: .temporaryRedirect(error))
            case .permanentRedirect:
                return .knownApiRedirections(error: .permanentRedirect(error))
            }
        }
        return .knownApiFailures(error: .failure(error))
    }
    
    static func handleAPIClientError(error: Error) -> ConnectorError {
        if let errorCode = LifeSupportApiClientErrorCode(rawValue: error._code) {
            switch errorCode {
                
            case .badRequest:
                return .knownApiClientErrors(error: .badRequest(error))
            case .unauthorized:
                return .knownApiClientErrors(error: .unauthorized(error))
            case .paymentRequired:
                return .knownApiClientErrors(error: .paymentRequired(error))
            case .forbidden:
                return .knownApiClientErrors(error: .forbidden(error))
            case .notFound:
                return .knownApiClientErrors(error: .notFound(error))
            case .methodNotAllowed:
                return .knownApiClientErrors(error: .methodNotAllowed(error))
            case .notAcceptable:
                return .knownApiClientErrors(error: .notAcceptable(error))
            case .proxyAuthenticationRequired:
                return .knownApiClientErrors(error: .proxyAuthenticationRequired(error))
            case .requestTimeout:
                return .knownApiClientErrors(error: .requestTimeout(error))
            case .conflict:
                return .knownApiClientErrors(error: .conflict(error))
            case .gone:
                return .knownApiClientErrors(error: .gone(error))
            case .lengthRequired:
                return .knownApiClientErrors(error: .lengthRequired(error))
            case .preconditionFailed:
                return .knownApiClientErrors(error: .preconditionFailed(error))
            case .payloadTooLarge:
                return .knownApiClientErrors(error: .payloadTooLarge(error))
            case .requestURITooLong:
                return .knownApiClientErrors(error: .requestURITooLong(error))
            case .unsupportedMediaType:
                return .knownApiClientErrors(error: .unsupportedMediaType(error))
            case .requestedRangeNotSatisfiable:
                return .knownApiClientErrors(error: .requestedRangeNotSatisfiable(error))
            case .expectationFailed:
                return .knownApiClientErrors(error: .expectationFailed(error))
            case .imTeapot:
                return .knownApiClientErrors(error: .imTeapot(error))
            case .misdirectedRequest:
                return .knownApiClientErrors(error: .misdirectedRequest(error))
            case .unprocessableEntity:
                return .knownApiClientErrors(error: .unprocessableEntity(error))
            case .locked:
                return .knownApiClientErrors(error: .locked(error))
            case .failedDependency:
                return .knownApiClientErrors(error: .failedDependency(error))
            case .upgradeRequired:
                return .knownApiClientErrors(error: .upgradeRequired(error))
            case .preconditionRequired:
                return .knownApiClientErrors(error: .preconditionRequired(error))
            case .tooManyRequests:
                return .knownApiClientErrors(error: .tooManyRequests(error))
            case .requestHeaderFieldsTooLarge:
                return .knownApiClientErrors(error: .requestHeaderFieldsTooLarge(error))
            case .connectionClosedWithoutResponse:
                return .knownApiClientErrors(error: .connectionClosedWithoutResponse(error))
            case .unavailableForLegalReasons:
                return .knownApiClientErrors(error: .unavailableForLegalReasons(error))
            case .clientClosedRequest:
                return .knownApiClientErrors(error: .clientClosedRequest(error))
            }
        }
        return .knownApiFailures(error: .failure(error))
    }
    
    static func handleAPIServerError(error: Error) -> ConnectorError {
        if let errorCode = LifeSupportApiServerErrorCode(rawValue: error._code) {
            switch errorCode {
                
            case .internalServerError:
                return .knownApiServerErrors(error: .internalServerError(error))
            case .notImplemented:
                return .knownApiServerErrors(error: .notImplemented(error))
            case .badGateway:
                return .knownApiServerErrors(error: .badGateway(error))
            case .serviceUnavailable:
                return .knownApiServerErrors(error: .serviceUnavailable(error))
            case .gatewayTimeout:
                return .knownApiServerErrors(error: .gatewayTimeout(error))
            case .httpVersionNotSupported:
                return .knownApiServerErrors(error: .httpVersionNotSupported(error))
            case .variantAlsoNegotiates:
                return .knownApiServerErrors(error: .variantAlsoNegotiates(error))
            case .insufficientStorage:
                return .knownApiServerErrors(error: .insufficientStorage(error))
            case .loopDetected:
                return .knownApiServerErrors(error: .loopDetected(error))
            case .notExtended:
                return .knownApiServerErrors(error: .notExtended(error))
            case .networkAuthenticationRequired:
                return .knownApiServerErrors(error: .networkAuthenticationRequired(error))
            case .networkConnectTimeoutError:
                return .knownApiServerErrors(error: .networkConnectTimeoutError(error))
            }
        }
        return .knownApiFailures(error: .failure(error))
    }
    
    static func handleAPIError(error: Error) -> ConnectorError {
        if let errorCode = LifeSupportApiErrorCode(rawValue: error._code) {
            switch errorCode {
                
            case .invalidParams:
                return .knownApiFailures(error: .invalidParams(error))
            case .failure:
                return .knownApiFailures(error: .failure(error))
            case .invalidResponse:
                return .knownApiFailures(error: .invalidResponse(error))
            case .clientOrServerError:
                return .knownApiFailures(error: .clientOrServerError(error))
            case .nonDataClientOrServerError:
                return .knownApiFailures(error: .nonDataClientOrServerError(error))
            case .noFlowErrorCode:
                return .knownApiFailures(error: .noFlowErrorCode(error))
            case .noInternetErrorCode, .noInternetErrorCodeIOS7:
                return .knownApiFailures(error: .noInternetErrorCode(error))
            case .requestTimeOut:
                return .knownApiFailures(error: .requestTimeout(error))
            case .requestFailedForbidden:
                return .knownApiFailures(error: .requestFailedForbidden(error))
            case .emptySecurityData:
                return .knownApiFailures(error: .emptySecurityData(error))
            case .idleSessionTimeout:
                return .knownApiFailures(error: .idleSessionTimeout(error))
            case .sessionTimeout:
                return .knownApiFailures(error: .sessionTimeout(error))
            case .sdkTimeout:
                return .knownApiFailures(error: .sdkTimeout(error))
            }
        }
        return .knownApiFailures(error: ConnectorError.Enums.KnownApiFailures.failure(ConnectorError.customError(domain: "UnkownError", localizedDescription: "API unkown Error")))
    }
}
