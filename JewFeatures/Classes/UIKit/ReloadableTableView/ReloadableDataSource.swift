//
//  MarketModel.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 14/04/20.
//

import Foundation

public protocol ReloadableDelegate: class {
    func apply(changes: SectionChanges)
    func didSelected(indexpath: IndexPath, cell: ReloadableCellProtocol?)
    func didAction(editItem: ReloadableEditItem, indexPath: IndexPath, cell: UITableViewCell?)
    func didRefresh()
    func top(section: IndexPath)
    func reachBottomEnd()
}

public class ReloadableDataSource: NSObject {
    
    public weak var delegate: ReloadableDelegate?
    var items = [ReloadableItem]()
    var editItems: [ReloadableEditItem]? = nil
    var sectionChanges = SectionChanges()
    
    public lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ReloadableDataSource.refresh), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    func setup(newItems: [ReloadableItem], editItems: [ReloadableEditItem]? = nil) {
            let oldData = self.flatten(items: self.items)
            let newData = self.flatten(items: newItems)
            self.sectionChanges = DiffCalculator.calculate(oldItems: oldData, newItems: newData)
            self.items = newItems
            self.editItems = editItems
    }
    
    func flatten(items: [ReloadableItem]) -> [ReloadableSection<CellItem>] {
        let reloadableItems = items
            .enumerated()
            .map { ReloadableSection(key: $0.element.sectionTitle ?? AES256Crypter.randomKey(), value: $0.element.cellItems
                .enumerated()
                .map { ReloadableCell(key: $0.element.id, value: $0.element, index: $0.offset)  }, index: $0.offset) }
        return reloadableItems
    }
    
    @objc private func refresh() {
        delegate?.didRefresh()
    }
}
