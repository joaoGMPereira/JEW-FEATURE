//
//  RelodableCellProtocol.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 16/04/20.
//

import Foundation

public protocol ReloadableCellProtocol {
    var item: CellItem? { get }
    var items: [CellItem]? { get }
    func set(item: CellItem?, row: Int)
}
