//
//  LifeSupportError+Enums.swift
//  LifeSupport
//
//  Created by Joao Gabriel Medeiros Perei on 05/02/20.
//

import Foundation


extension ConnectorError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .knownApiFailures(let error): return error.localizedDescription
        case .parserError(let error): return error.localizedDescription
        case .knownApiInformalFailures(let error): return error.localizedDescription
        case .knownApiRedirections(let error): return error.localizedDescription
        case .knownApiClientErrors(let error): return error.localizedDescription
        case .knownApiServerErrors(let error): return error.localizedDescription
        }
    }
}

extension ConnectorError.Enums.KnownApiClientErrors {
    func getParams() -> Error {
        switch self {
        case .badRequest(let error):
            return error
        case .unauthorized(let error):
            return error
        case .paymentRequired(let error):
            return error
        case .forbidden(let error):
            return error
        case .notFound(let error):
            return error
        case .methodNotAllowed(let error):
            return error
        case .notAcceptable(let error):
            return error
        case .proxyAuthenticationRequired(let error):
            return error
        case .requestTimeout(let error):
            return error
        case .conflict(let error):
            return error
        case .gone(let error):
            return error
        case .lengthRequired(let error):
            return error
        case .preconditionFailed(let error):
            return error
        case .payloadTooLarge(let error):
            return error
        case .requestURITooLong(let error):
            return error
        case .unsupportedMediaType(let error):
            return error
        case .requestedRangeNotSatisfiable(let error):
            return error
        case .expectationFailed(let error):
            return error
        case .imTeapot(let error):
            return error
        case .misdirectedRequest(let error):
            return error
        case .unprocessableEntity(let error):
            return error
        case .locked(let error):
            return error
        case .failedDependency(let error):
            return error
        case .upgradeRequired(let error):
            return error
        case .preconditionRequired(let error):
            return error
        case .tooManyRequests(let error):
            return error
        case .requestHeaderFieldsTooLarge(let error):
            return error
        case .connectionClosedWithoutResponse(let error):
            return error
        case .unavailableForLegalReasons(let error):
            return error
        case .clientClosedRequest(let error):
            return error
        }
    }
}

extension ConnectorError.Enums.KnownApiFailures {
    func getParams() -> Error {
        switch self {
        case .invalidParams(let error):
            return error
        case .failure(let error):
            return error
        case .invalidResponse(let error):
            return error
        case .clientOrServerError(let error):
            return error
        case .nonDataClientOrServerError(let error):
            return error
        case .noFlowErrorCode(let error):
            return error
        case .noInternetErrorCode(let error):
            return error
        case .emptySecurityData(let error):
            return error
        case .idleSessionTimeout(let error):
            return error
        case .sessionTimeout(let error):
            return error
        case .sdkTimeout(let error):
            return error
        case .requestTimeout(let error):
            return error
        case .requestFailedForbidden(let error):
            return error
        }
    }
}

extension ConnectorError.Enums.KnownApiInformalFailures {
    func getParams() -> Error {
        switch self {
        case .continue(let error):
            return error
        case .switchingProtocols(let error):
            return error
        case .processing(let error):
            return error
        }
    }
}

extension ConnectorError.Enums.KnownApiRedirections {
    func getParams() -> Error {
        switch self {
        case .multipleChoices(let error):
            return error
        case .movedPermanently(let error):
            return error
        case .found(let error):
            return error
        case .seeOther(let error):
            return error
        case .notModified(let error):
            return error
        case .useProxy(let error):
            return error
        case .temporaryRedirect(let error):
            return error
        case .permanentRedirect(let error):
            return error
        }
    }
}

extension ConnectorError.Enums.KnownApiServerErrors {
    func getParams() -> Error {
        switch self {
        case .internalServerError(let error):
            return error
        case .notImplemented(let error):
            return error
        case .badGateway(let error):
            return error
        case .serviceUnavailable(let error):
            return error
        case .gatewayTimeout(let error):
            return error
        case .httpVersionNotSupported(let error):
            return error
        case .variantAlsoNegotiates(let error):
            return error
        case .insufficientStorage(let error):
            return error
        case .loopDetected(let error):
            return error
        case .notExtended(let error):
            return error
        case .networkAuthenticationRequired(let error):
            return error
        case .networkConnectTimeoutError(let error):
            return error
        }
    }
}

extension ConnectorError.Enums.ParserError {
    func getParams() -> Error {
        switch self {
        case .parserError(let error):
            return error
        case .failedToParser(let error):
            return error
        }
    }
}

enum LifeSupportErrorConstants: String {
    case parsing = "Parsing error"
    case unkownError = "Unkown error"
    case urlNotFound = "URL Not Found"
}
