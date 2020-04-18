//
//  ReloadableItem.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 16/04/20.
//

import Foundation
public protocol ReloadableItem {
    var sectionTitle: String? { get }
    var cellItems: [CellItem] { get }
    var cellType: String { get }
}

public struct CellItem: Equatable {
    public var value: CustomStringConvertible
    public var object: Decodable
    public var id: String
    public var bundle: Bundle
    
    public init(value: CustomStringConvertible, object: Decodable, id: String, bundle: Bundle) {
        self.value = value
        self.object = object
        self.id = id
        self.bundle = bundle
    }
    
    public static func ==(lhs: CellItem, rhs: CellItem) -> Bool {
        return lhs.id == rhs.id && lhs.value.description == rhs.value.description
    }
}
