//
//  InvestScopioSession.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 29/05/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation

public enum ServiceType: Int {
    case localHost = 0
    case heroku
    case offline
}

public final class JEWSession {
    
    // Can't init is singleton
    private init() { }

    public static let session = JEWSession()
    public var user: JEWUserModel?
    public var callService: ServiceType = .heroku
    
    public func isDev() -> Bool {
        //#if DEV
        return true
        //#else
        //return false
        //#endif
    }


    
}
