//
//  TargetType.swift
//  LifeSupport
//
//  Created by Joao Gabriel Medeiros Perei on 31/01/20.
//

import Foundation
import Alamofire


protocol LifeSupportTargetType {
    /// The params to be used in the request.
    var params: String? { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var endPoint: String { get }
    
    /// The contentType to be used in the request.
    var contentType: String { get }
    
    /// The HTTP method used in the request.
    var httpMethod: HTTPMethod { get }
    
}

extension LifeSupportTargetType {
    func getBaseURL() -> String {
        return "http://caronte-security-proxy.dev.aws.cloud.ihf:443/charon/lifesup"
    }
}
