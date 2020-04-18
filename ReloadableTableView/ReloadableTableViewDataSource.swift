//
//  MarketModel.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 14/04/20.
//

import Foundation

public protocol ReloadableDelegate: class {
    func apply(changes: SectionChanges)
    func didSelected(indexpath: IndexPath, cell: UITableViewCell?)
    func didAction(editItem: ReloadableEditItem, indexPath: IndexPath, cell: UITableViewCell?)
}

public class ReloadableTableViewDataSource: NSObject {
    
    public weak var delegate: ReloadableDelegate?
    var items = [ReloadableItem]()
    private var editItems: [ReloadableEditItem]? = nil
    
    public func setup(newItems: [ReloadableItem], in tableView: UITableView, editItems: [ReloadableEditItem]? = nil) {
        let oldData = flatten(items: items)
        let newData = flatten(items: newItems)
        let sectionChanges = DiffCalculator.calculate(oldItems: oldData, newItems: newData)
        items = newItems
        self.editItems = editItems
        register(tableView: tableView)
        delegate?.apply(changes: sectionChanges)
    }
    
    private func flatten(items: [ReloadableItem]) -> [ReloadableSection<CellItem>] {
        let reloadableItems = items
            .enumerated()
            .map { ReloadableSection(key: $0.element.cellType.className, value: $0.element.cellItems
                .enumerated()
                .map { ReloadableCell(key: $0.element.id, value: $0.element, index: $0.offset)  }, index: $0.offset) }
        return reloadableItems
    }
    
    private func register(tableView: UITableView) {
        items.forEach { (item) in
            for cellItem in item.cellItems {
                tableView.register(UINib(nibName: item.cellType, bundle: cellItem.bundle), forCellReuseIdentifier: item.cellType)
            }
        }
    }
}

extension ReloadableTableViewDataSource: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].cellItems.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.cellType, for: indexPath) as? ReloadableCellProtocol

        cell?.set(item: item.cellItems[indexPath.row], row: indexPath.row)
        if let cell = cell as? UITableViewCell {
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
}


extension ReloadableTableViewDataSource: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           delegate?.didSelected(indexpath: indexPath, cell: tableView.cellForRow(at: indexPath))
       }
       
       public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return editItems?.count ?? 0 > 0
       }

       public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return ReloadableEditItem.setTableViewRows(items: editItems, tableView: tableView, indexPath: indexPath, delegate: delegate)
       }
       
       public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
           return tableView.isEditing ? UITableViewCell.EditingStyle.none : UITableViewCell.EditingStyle.delete
       }
       
       public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
           return true
       }
       
       public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
           
       }
}
