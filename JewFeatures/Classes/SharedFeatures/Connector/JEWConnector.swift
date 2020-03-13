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
    
    public static let connector = JEWConnector()
    public var baseURL: String = JEWConstants.Services.localHost.rawValue
    public static func getURL(withRoute route: String) -> URL? {
        let baseURL = URL(string: "\(JEWConnector.connector.baseURL)\(route)")
        return baseURL
    }
    public var sessionToken: String? = nil
    
    public func request<T: Decodable>(withRoute route: String, method: HTTPMethod = .get, parameters: JSONAble? = nil, responseClass: T.Type, headers: HTTPHeaders? = nil, shouldRetry: Bool = false, successCompletion: @escaping(SuccessResponse), errorCompletion: @escaping(ErrorCompletion)) {
        var headersUpdated = headers
        guard let url = JEWConnector.getURL(withRoute: route) else {
            return
        }
        if let sessionToken = self.sessionToken {
            if headersUpdated == nil {
               headersUpdated = HTTPHeaders()
            }
            headersUpdated?.updateValue(sessionToken, forKey: "session-token")
        }
        
        self.requestBlock(withURL: url, method: method, parameters: parameters, responseClass: responseClass, headers: headersUpdated, successCompletion: { (decodable) in
            successCompletion(decodable)
        }) { (error) in
            if shouldRetry {
                self.request(withRoute: route, method: method, parameters: parameters, responseClass: responseClass, headers: headers, shouldRetry: false, successCompletion: successCompletion, errorCompletion: errorCompletion)
                return
            }
            errorCompletion(error)
        }
        
    }
    
    public func requestBlock<T: Decodable>(withURL url: URL, method: HTTPMethod = .get, parameters: JSONAble? = nil, responseClass: T.Type, headers: HTTPHeaders? = nil, successCompletion: @escaping(SuccessResponse), errorCompletion: @escaping(ErrorCompletion)) {
        
        Alamofire.request(url, method: method, parameters: parameters?.toDict(), encoding: JSONEncoding.default, headers: headers).validate().responseJSON { (response) in
            self.logRequestInfo(withURL: url, method: method, parameters: parameters, headers: headers)
            if let error = response.error {
                errorCompletion(ConnectorError.handleError(error: error))
                return
            }
             
            let responseResult = response.result
            if let error = responseResult.error {
               errorCompletion(ConnectorError.handleError(error: error))
                return
            }
            switch responseResult {
            case .success:
                do {
                    if let data = response.data {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        JEWLogger.info(json)
                        let decodable = try JSONDecoder().decode(T.self, from: data)
                        successCompletion(decodable)
                    } else {
                        let error = ConnectorError.handleError(error: ConnectorError.customError(domain: "Response Data Nil", code: -1, localizedDescription: "Response Data Nil"))
                        JEWLogger.error(error)
                        errorCompletion(error)
                    }
                    break
                }
                catch(let error) {
                    JEWLogger.error(error)
                    errorCompletion(ConnectorError.handleError(error: error))
                    break
                }
            case .failure(let error):
                JEWLogger.error(error)
                errorCompletion(ConnectorError.handleError(error: error))
                break
            }
        }
    }
    
    func logRequestInfo(withURL url: URL, method: HTTPMethod = .get, parameters: JSONAble? = nil, headers: HTTPHeaders? = nil) {
        let requestURL = "RequestURL: \(url)\n"
        let methodURL = "Method: \(method.rawValue)\n"
        
        var parametersDict = String()
        if let dict = parameters?.toDict() {
            parametersDict = "ParametersDict: \(dict))\n"
        }
        
        var headerDict = String()
        if let header = headers {
            headerDict = "HeaderDict: \(header))\n"
        }
        
        let requestInfo = "\n\n-----------RequestINFO-----------\n\n\(requestURL)\(parametersDict)\(methodURL)\(headerDict)\n\n-----------RequestINFO-----------\n\n"
        
        JEWLogger.info(requestInfo, shouldAddPreSufix: false)
    }
}
