//
//  INVSUserModel.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 18/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation

public enum JEWUserRole: Int {
    case admin
    case client
}

public struct JEWUserModel: JSONAble {
    public var email: String
    public var fullName: String
    public var photoURL: URL?
    public var photoImage: UIImage?
    public var uid: String = String()
    public var access: JEWAccessModel? = nil
    public var role: JEWUserRole = .client
    
    public init(email: String?, uid: String, fullName: String?, photoURL: URL? = nil) {
        self.email = email ?? "User Without Email"
        self.uid = uid
        self.fullName = fullName ?? "User Without Name"
        self.photoURL = photoURL
    }
}
