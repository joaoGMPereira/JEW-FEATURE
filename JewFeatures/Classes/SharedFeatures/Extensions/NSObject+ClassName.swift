//
//  NSObject+ClassName.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 13/04/20.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}
public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
    var className: String {
        return type(of: self).className
    }
}
extension NSObject: ClassNameProtocol {}
