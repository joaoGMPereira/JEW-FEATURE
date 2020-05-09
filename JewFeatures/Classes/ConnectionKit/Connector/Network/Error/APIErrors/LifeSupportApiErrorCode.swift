//
//  LifeSupportApiErrorCode.swift
//  LifeSupport
//
//  Created by Joao Gabriel Medeiros Perei on 05/02/20.
//

import Foundation

public enum LifeSupportApiParserErrorCode: Int, CaseIterable {
    case parserError = 907
    case failedToParser = 908
}

public enum LifeSupportApiNetworkErrorCode: Int, CaseIterable {
    case parserError = 909
    case failedToParser = 910
}


public enum LifeSupportApiErrorCode: Int, CaseIterable {
    case invalidParams = 901
    case failure = 902
    case invalidResponse = 903
    case clientOrServerError = 904
    case nonDataClientOrServerError = 905
    case noFlowErrorCode = -1
    case noInternetErrorCode = -1009
    case noInternetErrorCodeIOS7 = -1004
    case requestTimeOut = -1001
    case requestFailedForbidden = -1011
    case emptySecurityData = 3
    case idleSessionTimeout = 4
    case sessionTimeout = 5
    case sdkTimeout = 850
}

public enum LifeSupportApiInformalCode: Int, CaseIterable {
    case `continue` = 100
    case switchingProtocols = 101
    case processing = 102
}

public enum LifeSupportApiSuccessCode: Int, CaseIterable {
    case ok = 200
    case created = 201
    case accepted = 202
    case nonAuthoritativeInformation = 203
    case noContent = 204
    case resetContent = 205
    case partialContent = 206
    case multiStatus = 207
    case alreadyReported = 208
    case imUsed = 226
}

public enum LifeSupportApiRedirectionCode: Int, CaseIterable {
    case multipleChoices = 300
    case movedPermanently = 301
    case found = 302
    case seeOther = 303
    case notModified = 304
    case useProxy = 305
    case temporaryRedirect = 307
    case permanentRedirect = 308
}

public enum LifeSupportApiClientErrorCode: Int, CaseIterable {
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case requestTimeout = 408
    case conflict = 409
    case gone = 410
    case lengthRequired = 411
    case preconditionFailed = 412
    case payloadTooLarge = 413
    case requestURITooLong = 414
    case unsupportedMediaType = 415
    case requestedRangeNotSatisfiable = 416
    case expectationFailed = 417
    case imTeapot = 418
    case misdirectedRequest = 421
    case unprocessableEntity = 422
    case locked = 423
    case failedDependency = 424
    case upgradeRequired = 426
    case preconditionRequired = 428
    case tooManyRequests = 429
    case requestHeaderFieldsTooLarge = 431
    case connectionClosedWithoutResponse = 444
    case unavailableForLegalReasons = 451
    case clientClosedRequest = 499
}

public enum LifeSupportApiServerErrorCode: Int, CaseIterable {
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    case httpVersionNotSupported = 505
    case variantAlsoNegotiates = 506
    case insufficientStorage = 507
    case loopDetected = 508
    case notExtended = 510
    case networkAuthenticationRequired = 511
    case networkConnectTimeoutError = 599
}

