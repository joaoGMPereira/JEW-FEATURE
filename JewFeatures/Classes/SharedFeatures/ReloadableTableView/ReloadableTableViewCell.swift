//
//  ReloadableTableViewCell.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 19/04/20.
//

import UIKit

public class ReloadableTableViewCell: UITableViewCell, ReloadableCellProtocol, ReloadableDelegate {
    
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
            datasource.delegate = self
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
    
    public func apply(changes: SectionChanges) {
          self.collectionView.performBatchUpdates({
          self.collectionView.deleteSections(changes.deletes)
          self.collectionView.insertSections(changes.inserts)
          
          self.collectionView.reloadItems(at: changes.updates.reloads)
          self.collectionView.insertItems(at: changes.updates.inserts)
          self.collectionView.deleteItems(at: changes.updates.deletes)
            self.collectionView.layoutIfNeeded()
        })
          
      }
      
      public func didSelected(indexpath: IndexPath, cell: UITableViewCell?) {
          
      }
      
      public func didAction(editItem: ReloadableEditItem, indexPath: IndexPath, cell: UITableViewCell?) {
          
      }
      
      public func didRefresh() {
      }
    
}
