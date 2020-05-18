//
//  Date+JEWExtension.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 18/05/20.
//

import Foundation

public extension Date {
    func toString(withFormat format: String = "dd/MM/yyyy HH:mm:ss") -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt-BR")
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)

        return str
    }
}
