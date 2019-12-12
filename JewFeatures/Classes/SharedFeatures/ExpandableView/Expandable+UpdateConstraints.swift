//
//  Expandable+UpdateConstraints.swift
//  DailyRewards
//
//  Created by Joao Gabriel Medeiros Perei on 26/11/19.
//  Copyright © 2019 Joao Gabriel Medeiros Perei. All rights reserved.
//

import Foundation
import UIKit

extension ExpandableView {
    public func changeConstants(shouldExpand: Bool) {
        
        if(shouldExpand) {
            expandTitleCenterX()
            expandImageCenterXY()
            expandImageHeight()
            expandImageHeight()
            expandImageWidth()
        } else {
            collapseTitleCenterX()
            collapseIconCenterXY()
            collapseIconHeight()
            collapseIconWidth()
        }
        UIView.animate(withDuration: ExpandableViewConstants.animationDuration) {
            self.layoutIfNeeded()
            self.iconImageView.setupRounded(borderColor: .white)
        }
    }
    
    //MARK - Collapse
    private func collapseTitleCenterX() {
        let distanceBetweenTitleAndView = titleLabel.frame.minX - frame.minX
        if titleLabel.frame.origin.x != ExpandableViewConstants.padding {
            let incrementValue = ExpandableViewConstants.padding - distanceBetweenTitleAndView
            updateConstraint(constraint: titleCenterXConstraint, fixedConstant: incrementValue)
        }
    }
    
    private func collapseIconCenterXY() {
        let distanceBetweenIconAndView = frame.maxX - iconImageView.frame.maxX + ExpandableViewConstants.minimumSizeImage/2
        if distanceBetweenIconAndView != ExpandableViewConstants.padding {
            let decrementValue = distanceBetweenIconAndView - ExpandableViewConstants.padding
            updateConstraint(constraint: imageCenterXConstraint, fixedConstant: decrementValue)
            collapseImageCenterY()
        }
    }
    
    private func collapseImageCenterY() {
        if let collapseHeaderCallback = collapseHeaderCallback, imageCenterYConstraint.constant != ExpandableViewConstants.zero {
            updateConstraint(constraint: imageCenterYConstraint, fixedConstant: ExpandableViewConstants.zero)
            collapseHeaderCallback()
        }
    }
    
    private func collapseIconHeight() {
        if imageHeightConstraint.constant > ExpandableViewConstants.minimumSizeImage {
            updateConstraint(constraint: imageHeightConstraint, fixedConstant: ExpandableViewConstants.minimumSizeImage)
        }
    }
    
    private func collapseIconWidth() {
        if imageWidthConstraint.constant > ExpandableViewConstants.minimumSizeImage {
            updateConstraint(constraint: imageWidthConstraint, fixedConstant: ExpandableViewConstants.minimumSizeImage)
        }
    }
    
    //MARK - Expand
    private func expandTitleCenterX() {
        let distanceBetweenTitleAndView = titleLabel.center.x - center.x
        if distanceBetweenTitleAndView < ExpandableViewConstants.zero {
            updateConstraint(constraint: titleCenterXConstraint, fixedConstant: ExpandableViewConstants.zero)
        }
    }
    
    private func expandImageCenterXY() {
        let distanceBetweenImageAndView = iconImageView.center.x - center.x
        if distanceBetweenImageAndView > ExpandableViewConstants.zero {
            updateConstraint(constraint: imageCenterXConstraint, fixedConstant: ExpandableViewConstants.zero)
            expandImageCenterY()
        }
    }
    
    private func expandImageCenterY() {
        if let expandHeaderCallback = expandHeaderCallback {
            updateConstraint(constraint: imageCenterYConstraint, fixedConstant: ExpandableViewConstants.padding)
            expandHeaderCallback()
        }
    }
    
    private func expandImageHeight() {
        if imageHeightConstraint.constant < ExpandableViewConstants.maximumSizeImage {
            updateConstraint(constraint: imageHeightConstraint, fixedConstant: ExpandableViewConstants.maximumSizeImage)
        }
    }
    
    private func expandImageWidth() {
        if imageWidthConstraint.constant < ExpandableViewConstants.maximumSizeImage {
            updateConstraint(constraint: imageWidthConstraint, fixedConstant: ExpandableViewConstants.maximumSizeImage)
        }
    }
    
    private func updateIncrementConstraint(constraint: NSLayoutConstraint, constant: CGFloat) {
        constraint.constant += constant
    }
    
    private func updateDecrementConstraint(constraint: NSLayoutConstraint, constant: CGFloat) {
        constraint.constant -= constant
    }
    
    private func updateConstraint(constraint: NSLayoutConstraint, fixedConstant: CGFloat) {
        constraint.constant = fixedConstant
    }
}
