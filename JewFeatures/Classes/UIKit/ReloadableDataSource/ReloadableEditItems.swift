//
//  ReloadableEditItems.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 16/04/20.
//

import Foundation

public enum ReloadableEditItem {
    case edit
    case delete
    case add
    case other(name: String, style: UITableViewRowAction.Style)
    
    func title() -> String {
        var title = ""
        switch self {
        case .edit:
            title = "Editar"
        case .delete:
            title = "Apagar"
        case .add:
            title = "Adicionar"
        case .other(let name, _):
            title = name
        }
        return title
    }
    
    func style() -> UITableViewRowAction.Style {
        var style = UITableViewRowAction.Style.default
        switch self {
        case .edit:
            style = UITableViewRowAction.Style.normal
        case .delete:
            style = UITableViewRowAction.Style.destructive
        case .add:
            style = UITableViewRowAction.Style.normal
        case .other( _, let otherStyle):
            style = otherStyle
        }
        return style
    }
    
    static func setTableViewRows(items: [ReloadableEditItem]?, tableView: UITableView, indexPath: IndexPath, delegate: ReloadableDelegate?) -> [UITableViewRowAction]? {
        var rowActions = [UITableViewRowAction]()
        guard let items = items else {
            return nil
        }
        for item in items {
            let rowAction = UITableViewRowAction(style: item.style(), title: item.title(), handler:{action, indexpath in
                tableView.isEditing = false
                delegate?.didAction(editItem: item, indexPath: indexPath, cell: tableView.cellForRow(at: indexPath))
            })
            rowActions.append(rowAction)
        }
        return rowActions
    }
}
