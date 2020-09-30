//
//  InvestScopioSession.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 29/05/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation

public class JEWSession {
    
    // Can't init is singleton
    private init() { }

    public static let session = JEWSession()
    public var user: JEWUserModel?
    public var services = JewSessionServices()
    public static var bundle: Bundle {
        return Bundle(for: JEWSession.self)
    }
}

public class JewSessionServices {
    public var publicKey: String = ""
    public var token: String = ""
    public var sessionToken: String = ""
    public var scheme = Scheme.scheme
}
