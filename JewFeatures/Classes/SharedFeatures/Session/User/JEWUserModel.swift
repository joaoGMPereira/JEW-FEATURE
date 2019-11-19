//
//  INVSUserModel.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 18/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation

struct JEWUserModel: JSONAble {
    var email: String = ""
    var uid: String = ""
    var syncronized: Bool = false
    var access: JEWAccessModel? = nil
    
    init(email: String, uid: String) {
        self.email = email
        self.uid = uid
    }
}
