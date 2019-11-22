//
//  Connector.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 05/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import Alamofire
public typealias SuccessResponse = (Decodable) -> ()
public typealias FinishResponse = () -> ()
public typealias SuccessRefreshResponse = (_ shouldUpdateHeaders: Bool) -> ()
public typealias ErrorCompletion = (ConnectorError) -> ()


public final class JEWConnector {
    
    // Can't init is singleton
    private init() { }
    
    static let connector = JEWConnector()
    let urlPath: String = JEWConstants.Services.localHost.rawValue
    public static func getURL(withRoute route: String) -> URL? {
        let baseURL = URL(string: route)
        return baseURL
    }
    
    public static func getVersion() -> URL? {
        return getURL(withRoute: JEWConstants.Services.version.rawValue)
    }
    
    public func request<T: Decodable>(withRoute route: ConnectorRoutes, method: HTTPMethod = .get, parameters: JSONAble? = nil, responseClass: T.Type, headers: HTTPHeaders? = nil, shouldRetry: Bool = false, successCompletion: @escaping(SuccessResponse), errorCompletion: @escaping(ErrorCompletion)) {
        
        guard let url = route.getRoute() else {
            return
        }
        
        refreshToken(withRoute: route, successCompletion: { (shouldUpdateHeaders) in
            var headersUpdated = headers
            if shouldUpdateHeaders {
                guard let headersWithAccessToken = ["Content-Type": "application/json", "Authorization": JEWSession.session.user?.access?.accessToken] as? HTTPHeaders else {
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
                        errorCompletion(ConnectorError.init(error: .none, title: JEWFloatingTextFieldType.defaultErrorTitle(), message: apiError.reason))
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
                errorCompletion(ConnectorError.init(error: .logout, message: JEWConstants.Default.invalidURL.rawValue))
                return
            }
            guard let refreshToken = JEWSession.session.user?.access?.refreshToken else {
                errorCompletion(ConnectorError.init(error: .logout, message: JEWConstants.RefreshErrors.invalidRefreshToken.rawValue))
                return
            }
            guard let headers = ["Content-Type": "application/json", "Authorization": JEWSession.session.user?.access?.accessToken] as? HTTPHeaders else {
                errorCompletion(ConnectorError.init(error: .logout, message: JEWConstants.RefreshErrors.invalidAccessToken.rawValue))
                return
            }
            let refreshTokenRequest = JEWRefreshTokenRequest.init(refreshToken: refreshToken)
            requestBlock(withURL: url, method: .post, parameters: refreshTokenRequest, responseClass: JEWAccessModel.self, headers: headers, successCompletion: { (decodable) in
                let accessModel = decodable as? JEWAccessModel
                JEWSession.session.user?.access = accessModel
                successCompletion(true)
            }) { (error) in
                errorCompletion(ConnectorError.init(error: .expiredSession, message: JEWConstants.Default.expiredSession.rawValue))
            }
        } else {
            successCompletion(false)
        }
    }
}
