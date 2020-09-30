//
//  JEWUserResponse.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 10/08/20.
//

import Foundation

public struct JEWUserResponse: Codable, JSONAble {
    public var email: String
    public var name: String
    public var firebaseID: String
    public var picture: String?
    public var created: String?
    public var __v: Int?
    public var _id: String?
}
