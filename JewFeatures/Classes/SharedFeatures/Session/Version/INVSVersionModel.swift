//
//  INVSVersionModel.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 05/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
struct INVSStatusModel: Codable {
    var code: Int
    var status: String
}
struct INVSVersionModel: Codable {

    var version: String
    var statusQuo: INVSStatusModel
    
}
