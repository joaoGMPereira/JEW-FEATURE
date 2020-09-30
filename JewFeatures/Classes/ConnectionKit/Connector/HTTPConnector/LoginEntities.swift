//
//  PublicKey.swift
//  InvestScopio
//
//  Created by Joao Gabriel Pereira on 01/08/20.
//  Copyright © 2020 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import Combine

public struct HTTPPublicKey: Codable {
    public let publicKey: String
}

public struct HTTPAccessToken: Codable {
    public let accessToken: String
}

public struct SessionTokenModel: Codable {
    public let sessionToken: String
}

@available(iOS 13.0, *)
public class UserModel: ObservableObject, Codable, JSONAble {
    public var email: String = ""
    public var uid: String = ""
    public var syncronized: Bool? = false
    public var access: AccessModel? = nil
    
    public  init(email: String, uid: String) {
        self.email = email
        self.uid = uid
    }
}

@available(iOS 13.0, *)
public class AccessModel: ObservableObject, Codable {
    public let refreshToken: String?
    public let accessToken: String
    public let expiredAt: Date?
    public let userID: Int?
    
    public required init(refreshToken: String, accessToken: String, expiredAt: Date, userID: Int?) {
        self.refreshToken = refreshToken
        self.accessToken = accessToken
        self.expiredAt = expiredAt
        self.userID = userID
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MyStructKeys.self)
        let refreshToken: String = try container.decode(String.self, forKey: .refreshToken)
        let accessToken: String = try container.decode(String.self, forKey: .accessToken)
        let expiredAt: String = try container.decode(String.self, forKey: .expiredAt)
        let userId: Int = try container.decode(Int.self, forKey: .userID)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let expiredAtDate = formatter.date(from: expiredAt)!
        self.init(refreshToken: refreshToken, accessToken: accessToken, expiredAt: expiredAtDate, userID: userId)
    }
    
}

@available(iOS 13.0, *)
extension AccessModel {
    enum MyStructKeys: String, CodingKey { // declaring our keys
        case refreshToken = "refreshToken"
        case accessToken = "accessToken"
        case expiredAt = "expiredAt"
        case userID = "userID"
    }
}

