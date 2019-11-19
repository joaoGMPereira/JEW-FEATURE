//
//  MarketModel.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 05/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation

struct TaxModel {
    var name: String = ""
    var signal: String = ""
    var value: Double = 0.0
}

struct MarketModel {
    var selic: TaxModel = TaxModel()
    var ipca: TaxModel = TaxModel()
    var ibov: TaxModel = TaxModel()
    var error: String? = nil
}
