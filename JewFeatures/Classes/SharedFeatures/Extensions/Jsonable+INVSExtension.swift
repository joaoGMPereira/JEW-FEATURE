//
//  Jsonable+INVSExtension.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 19/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation

protocol JSONAble {}

extension JSONAble {
    func toDict() -> [String:Any] {
        var dict = [String:Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }
}
