//
//  INVSUserModel.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 18/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation

public struct JEWUserModel: JSONAble {
    public var email: String = ""
    public var fullName: String?
    public var photoURL: URL?
    public var photoImage: UIImage?
    public var uid: String = ""
    public var syncronized: Bool = false
    public var access: JEWAccessModel? = nil
    
    public init(email: String, uid: String, fullName: String? = nil, photoURL: URL? = nil) {
        self.email = email
        self.uid = uid
        self.fullName = fullName
        self.photoURL = photoURL
    }
}
