//
//  INVSAccessModel.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 19/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation

struct JEWAccessModel {
    let refreshToken: String
    let accessToken: String
    let expiredAt: Date
    let userID: Int?
}

extension JEWAccessModel: Decodable {
    enum MyStructKeys: String, CodingKey { // declaring our keys
        case refreshToken = "refreshToken"
        case accessToken = "accessToken"
        case expiredAt = "expiredAt"
        case userID = "userID"
    }
    
    init(from decoder: Decoder) throws {
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

