//
//  ReloadableDataSource+TableView.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 18/04/20.
//

import Foundation

public extension ReloadableDataSource {
    
    func setup(newItems: [ReloadableItem], in tableView: UITableView, editItems: [ReloadableEditItem]? = nil, hasRefreshControl: Bool = false) {
        setup(newItems: newItems, editItems: editItems)
        register(tableView: tableView)
        if hasRefreshControl {
            setupRefreshControl(tableView: tableView)
        }
        delegate?.apply(changes: sectionChanges)
    }
    
    func setupRefreshControl(tableView: UITableView) {
        tableView.addSubview(refreshControl)
        refreshControl.tintColor = UIColor.JEWDarkDefault()
    }
    
    private func register(tableView: UITableView) {
        items.forEach { (item) in
            for cellItem in item.cellItems {
                tableView.register(UINib(nibName: item.cellType, bundle: cellItem.bundle), forCellReuseIdentifier: item.cellType)
            }
        }
    }
}


extension ReloadableDataSource: UITableViewDataSource {
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
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionTitle = items[section].sectionTitle else {
            return nil
        }
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        titleLabel.font = .JEW24Bold()
        titleLabel.textColor = .JEWBlack()
        titleLabel.text = sectionTitle
        titleLabel.backgroundColor = .JEWLightGray()
        let separator = UIView.init(frame: CGRect.init(x: 15, y: 49, width: tableView.frame.width - 15, height: 1))
        separator.backgroundColor = .JEWGray()
        titleLabel.addSubview(separator)
        return titleLabel
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if items[section].sectionTitle == nil {
            return 0
        }
        return 50
    }
    
}

extension ReloadableDataSource: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelected(indexpath: indexPath, cell: tableView.cellForRow(at: indexPath) as? ReloadableCellProtocol)
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
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let tableView = scrollView as? UITableView, let section = tableView.indexPathsForVisibleRows?.first {
            delegate?.top(section: section)
        }
        let height = scrollView.frame.size.height * 2
        let contentoffsetY = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentoffsetY
        
        if distanceFromBottom < height {
            delegate?.reachBottomEnd()
        }
    }
    
    //    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    //        if let tableView = scrollView as? UITableView, let section = tableView.indexPathsForVisibleRows?.first {
    //            delegate?.top(section: section)
    //        }
    //    }
}
