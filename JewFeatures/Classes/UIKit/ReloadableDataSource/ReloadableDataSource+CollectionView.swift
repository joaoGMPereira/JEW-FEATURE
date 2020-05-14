//
//  ReloadableDataSource+CollectionView.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 18/04/20.
//

import Foundation

public extension ReloadableDataSource {
    
    func setup(newItems: [ReloadableItem], in collectionView: UICollectionView, editItems: [ReloadableEditItem]? = nil, hasRefreshControl: Bool = false) {
        setup(newItems: newItems, editItems: editItems)
        register(collectionView: collectionView)
        if hasRefreshControl {
            setupRefreshControl(collectionView: collectionView)
        }
        delegate?.apply(changes: sectionChanges)
    }
    
    func setupRefreshControl(collectionView: UICollectionView) {
        collectionView.addSubview(refreshControl)
        refreshControl.tintColor = UIColor.JEWDefault()
    }
    
    func register(collectionView: UICollectionView) {
        self.items.forEach { (item) in
            for cellItem in item.cellItems {
                collectionView.register(UINib(nibName: item.cellType, bundle: cellItem.bundle), forCellWithReuseIdentifier: item.cellType)
            }
        }
    }
}


extension ReloadableDataSource: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].cellItems.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.section]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellType, for: indexPath) as? ReloadableCellProtocol
        
        if item.cellItems.indices.contains(indexPath.row) {
            cell?.set(item: item.cellItems[indexPath.row], row: indexPath.row)
        }
        if let cell = cell as? UICollectionViewCell {
            return cell
        }
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ReloadableCellProtocol
        cell?.didSelected()
        delegate?.didSelected(indexpath: indexPath, cell: cell)
        
    }
}
