//
//  ReloadableDataSource+CollectionView.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 18/04/20.
//

import Foundation

public extension ReloadableDataSource {
    
    func setup(newItems: [ReloadableItem], in collectionView: UICollectionView, editItems: [ReloadableEditItem]? = nil) {
        setup(newItems: newItems, editItems: editItems)
        register(collectionView: collectionView)
        setupRefreshControl(collectionView: collectionView)
        delegate?.apply(changes: sectionChanges)
    }
    
    func setupRefreshControl(collectionView: UICollectionView) {
        collectionView.addSubview(refreshControl)
        refreshControl.tintColor = UIColor.JEWDarkDefault()
    }
    
    func register(collectionView: UICollectionView) {

        items.forEach { (item) in
            for cellItem in item.cellItems {
                collectionView.register(UINib(nibName: item.cellType, bundle: cellItem.bundle), forCellWithReuseIdentifier: item.cellType)
            }
        }
    }
}


extension ReloadableDataSource: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].cellItems.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.section]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellType, for: indexPath) as? ReloadableCellProtocol
        
        cell?.set(item: item.cellItems[indexPath.row], row: indexPath.row)
        if let cell = cell as? UICollectionViewCell {
            return cell
        }
        return UICollectionViewCell()
    }
}
