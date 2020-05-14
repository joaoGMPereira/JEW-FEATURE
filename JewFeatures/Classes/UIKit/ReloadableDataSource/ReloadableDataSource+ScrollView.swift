//
//  ReloadableDataSource+ScrollView.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 12/05/20.
//

import Foundation

extension ReloadableDataSource: UIScrollViewDelegate {
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if let tableView = scrollView as? UITableView, let section = tableView.indexPathsForVisibleRows?.first {
//            delegate?.top(section: section)
//        }
        let height = scrollView.frame.size.height * 2
        let contentoffsetY = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentoffsetY
        
        if distanceFromBottom < height {
            delegate?.reachBottomEnd()
        }
    }

    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if let tableView = scrollView as? UITableView, let section = tableView.indexPathsForVisibleRows?.first {
                    delegate?.top(section: section)
                }
        
        
           let height = scrollView.frame.size.height
           let contentYoffset = scrollView.contentOffset.y
           let distanceFromBottom = scrollView.contentSize.height - contentYoffset
           if distanceFromBottom < height {
               delegate?.reachBottomEnd()
           }
       }

}
