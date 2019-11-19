//
//  Connector.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 05/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import Alamofire
typealias SuccessResponse = (Decodable) -> ()
typealias FinishResponse = () -> ()
typealias SuccessRefreshResponse = (_ shouldUpdateHeaders: Bool) -> ()
typealias ErrorCompletion = (ConnectorError) -> ()

final class JEWConnector {
    
    // Can't init is singleton
    private init() { }
    
    static let connector = INVSConector()
    let workerLogin: INVSLoginWorkerProtocol = INVSLoginWorker()
    
    static func getURL(withRoute route: String) -> URL? {
        var baseURL = URL(string: "\(INVSConstants.INVSServicesConstants.apiV1.rawValue)\(route)")
        if INVSSession.session.isDev() {
            baseURL = INVSSession.session.callService == .heroku ? URL(string: "\(INVSConstants.INVSServicesConstants.apiV1Dev.rawValue)\(route)") : URL(string: "\(INVSConstants.INVSServicesConstants.localHost.rawValue)\(route)")
        }
        return baseURL
    }
    
    static func getVersion() -> URL? {
        return getURL(withRoute: INVSConstants.INVSServicesConstants.version.rawValue)
    }
    
    func request<T: Decodable>(withRoute route: ConnectorRoutes, method: HTTPMethod = .get, parameters: JSONAble? = nil, responseClass: T.Type, headers: HTTPHeaders? = nil, shouldRetry: Bool = false, successCompletion: @escaping(SuccessResponse), errorCompletion: @escaping(ErrorCompletion)) {
        
        guard let url = route.getRoute() else {
            return
        }
        
        refreshToken(withRoute: route, successCompletion: { (shouldUpdateHeaders) in
            var headersUpdated = headers
            if shouldUpdateHeaders {
                guard let headersWithAccessToken = ["Content-Type": "application/json", "Authorization": INVSSession.session.user?.access?.accessToken] as? HTTPHeaders else {
                    errorCompletion(ConnectorError())
                    return
                }
                headersUpdated = headersWithAccessToken
            }
            self.requestBlock(withURL: url, method: method, parameters: parameters, responseClass: responseClass, headers: headersUpdated, successCompletion: { (decodable) in
                successCompletion(decodable)
            }) { (error) in
                if shouldRetry && error.error != .none {
                    self.request(withRoute: route, method: method, parameters: parameters, responseClass: responseClass, headers: headers, shouldRetry: false, successCompletion: successCompletion, errorCompletion: errorCompletion)
                    return
                }
                errorCompletion(error)
            }
        }) { (error) in
            errorCompletion(error)
        }
    }
    
    private func requestBlock<T: Decodable>(withURL url: URL, method: HTTPMethod = .get, parameters: JSONAble? = nil, responseClass: T.Type, headers: HTTPHeaders? = nil, successCompletion: @escaping(SuccessResponse), errorCompletion: @escaping(ErrorCompletion)) {
        Alamofire.request(url, method: method, parameters: parameters?.toDict(), encoding: JSONEncoding.default, headers: headers).validate().responseJSON { (response) in
            
            let responseResult = response.result
            if responseResult.error != nil {
                do {
                    if let data = response.data {
                        var apiError = try JSONDecoder().decode(ApiError.self, from: data)
                        apiError.error = false
                        errorCompletion(ConnectorError.init(error: .none, title: INVSFloatingTextFieldType.defaultErrorTitle(), message: apiError.reason))
                    } else {
                        errorCompletion(ConnectorError(error: .none))
                    }
                    return
                }
                catch {
                    errorCompletion(ConnectorError(error: .none))
                    return
                }
                
            }
            switch responseResult {
            case .success:
                do {
                    if let data = response.data {
                        let decodable = try JSONDecoder().decode(T.self, from: data)
                        successCompletion(decodable)
                    } else {
                        errorCompletion(ConnectorError(error: .none))
                    }
                    break
                }
                catch {
                    errorCompletion(ConnectorError(error: .none))
                    break
                }
            case .failure:
                errorCompletion((ConnectorError(error: .none)))
                break
            }
        }
    }
    
    private func refreshToken(withRoute route:ConnectorRoutes, successCompletion: @escaping(SuccessRefreshResponse), errorCompletion: @escaping(ErrorCompletion)) {
        if route != .signup &&  route != .signin &&  route != .logout {
            guard let url = ConnectorRoutes.refreshToken.getRoute() else {
                errorCompletion(ConnectorError.init(error: .logout, message: "URL Inválida!"))
                return
            }
            guard let refreshToken = INVSSession.session.user?.access?.refreshToken else {
                errorCompletion(ConnectorError.init(error: .logout, message: "Refresh Token Inválido!"))
                return
            }
            guard let headers = ["Content-Type": "application/json", "Authorization": INVSSession.session.user?.access?.accessToken] as? HTTPHeaders else {
                errorCompletion(ConnectorError.init(error: .logout, message: "Access Token Inválido!"))
                return
            }
            let refreshTokenRequest = INVSRefreshTokenRequest.init(refreshToken: refreshToken)
            requestBlock(withURL: url, method: .post, parameters: refreshTokenRequest, responseClass: INVSAccessModel.self, headers: headers, successCompletion: { (decodable) in
                let accessModel = decodable as? INVSAccessModel
                INVSSession.session.user?.access = accessModel
                successCompletion(true)
            }) { (error) in
                self.checkLoggedUser(successCompletion: {
                    successCompletion(true)
                }, errorCompletion: { (checkLoggedUserError) in
                    errorCompletion(checkLoggedUserError)
                })
            }
        } else {
            successCompletion(false)
        }
    }
    
    
    func checkLoggedUser(successCompletion: @escaping(FinishResponse), errorCompletion: @escaping(ErrorCompletion)) {
        let hasBiometricAuthenticationEnabled = INVSKeyChainWrapper.retrieveBool(withKey: INVSConstants.LoginKeyChainConstants.hasEnableBiometricAuthentication.rawValue)
        guard let hasBiometricAuthentication = hasBiometricAuthenticationEnabled, hasBiometricAuthentication == true else {
            errorCompletion(ConnectorError.init(error: .sessionExpired, title: AuthenticationError.sessionExpired.title(), message: AuthenticationError.sessionExpired.message()))
            return
        }
        INVSBiometricsChallenge.checkLoggedUser(reason: "Sessão expirada!\nAutentique novamente para continuar." ,successChallenge: {
            self.loginUserSaved(successCompletion: {
                successCompletion()
            }, errorCompletion: { (error) in
                errorCompletion(error)
            })
        }) { (challengeFailureType) in
            switch challengeFailureType {
            case .default:
                errorCompletion(ConnectorError.init(error: .logout))
                break
            case .error(let error):
                errorCompletion(ConnectorError.init(error: .authentication, title: error.title(), message: error.message(), shouldRetry: error.shouldRetry()))
                break
            case .goSettings(let error):
                errorCompletion(ConnectorError.init(error: .settings, title: error.title(), message: error.message()))
                break
            }
        }
    }
    
    private func loginUserSaved(successCompletion: @escaping(FinishResponse), errorCompletion: @escaping(ErrorCompletion)) {
        let email = INVSKeyChainWrapper.retrieve(withKey: INVSConstants.LoginKeyChainConstants.lastLoginEmail.rawValue)
        let security = INVSKeyChainWrapper.retrieve(withKey: INVSConstants.LoginKeyChainConstants.lastLoginSecurity.rawValue)
        if let emailRetrived = email, let securityRetrived = security {
            if let emailAES = INVSCrypto.decryptAES(withText: emailRetrived), let securityAES = INVSCrypto.decryptAES(withText: securityRetrived) {
                workerLogin.loggedUser(withEmail: emailAES, security: securityAES, successCompletionHandler: { (userResponse) in
                    INVSSession.session.user = userResponse
                    successCompletion()
                }) { (title, message, shouldHideAutomatically, popupType) in
                    INVSKeyChainWrapper.clear()
                    errorCompletion(ConnectorError.init(error: .logout))
                }
            } else {
                INVSKeyChainWrapper.clear()
                errorCompletion(ConnectorError.init(error: .logout))
            }
        } else {
            INVSKeyChainWrapper.clear()
            errorCompletion(ConnectorError.init(error: .logout))
        }
    }
    
    
}
