//
//  InvestScopioSession.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 29/05/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation

enum ServiceType: Int {
    case localHost = 0
    case heroku
    case offline
}

final class JEWSession {
    
    // Can't init is singleton
    private init() { }

    static let session = JEWSession()
    var user: JEWUserModel?
    var market: MarketModel?
    var callService: ServiceType = .heroku
    
    func isDev() -> Bool {
        #if DEV
        return true
        #else
        return false
        #endif
    }


    
}
