//
//  ReloadableTableViewCell.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 19/04/20.
//

import UIKit

public class ReloadableTableViewCell: UITableViewCell, ReloadableCellProtocol {
    public var items: [CellItem]?
    public var item: CellItem?
    var datasource = ReloadableDataSource()
    
    @IBOutlet weak var collectionView: UICollectionView!
    public func set(item: CellItem?, row: Int) {
       // configView()
        self.item = item
        if let reloadableSection = item?.object as? ReloadableItem {
            collectionView.dataSource = datasource
            datasource.setup(newItems: [reloadableSection], in: collectionView)
        }
        if let flow = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.estimatedItemSize = CGSize.init(width: 1, height: 1)
        }
        layoutIfNeeded()
    }
    
    private func configView() {
        layoutIfNeeded()
    }
    
    public override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        self.collectionView.layoutIfNeeded()
        return self.collectionView.collectionViewLayout.collectionViewContentSize
    }
    
}
