//
//  JEWPopupMessageLayout.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 18/04/20.
//

import Foundation

public enum JEWPopupMessageLayout {
    case top
    case paddingTop
    case bottom
    case paddingBottom
    
    func defaultHeight() -> CGFloat {
        var defaultHeight: CGFloat = 60
        switch self {
        case .top:
            defaultHeight = 110
            break
        case .paddingTop:
            defaultHeight = 60
            break
        case .bottom:
            defaultHeight = 110
            break
        case .paddingBottom:
            defaultHeight = 60
            break
        }
        return defaultHeight
    }
    
    func showPosition(popupHeight: CGFloat = 0) -> CGFloat {
        var topBarHeight: CGFloat = 60
        switch self {
        case .top:
            topBarHeight = 0
            break
        case .paddingTop:
            topBarHeight = UIApplication.shared.statusBarFrame.size.height + 10
            break
        case .bottom:
            topBarHeight = JEWDeviceInfo.height - popupHeight
            break
        case .paddingBottom:
            topBarHeight = JEWDeviceInfo.height - popupHeight - 20
            break
        }
        return topBarHeight
    }
    
    func hidePosition(popupHeight: CGFloat) -> CGFloat {
        var hidePosition: CGFloat = 0
        switch self {
        case .top, .paddingTop:
            hidePosition = -(UIApplication.shared.statusBarFrame.size.height + (UIViewController.topViewController()?.navigationController?.navigationBar.frame.height ?? 0.0) + popupHeight)
            break
        case .bottom, .paddingBottom:
            hidePosition = JEWDeviceInfo.height + popupHeight
            break
        }
        return hidePosition
    }
    
    func width() -> CGFloat {
        var width: CGFloat = 200
        switch self {
        case .top, .bottom:
            width = JEWDeviceInfo.width
            break
        case .paddingTop, .paddingBottom:
            width = JEWDeviceInfo.width * 0.9
            break
        }
        return width
    }
    
    func roundCorners() -> UIRectCorner {
        var corners: UIRectCorner
        switch self {
        case .top:
            corners = [.bottomLeft, .bottomRight]
            break
        case .paddingTop:
            corners = .allCorners
            break
        case .bottom:
            corners = [.topLeft, .topRight]
            break
        case .paddingBottom:
            corners = .allCorners
            break
        }
        return corners
    }
    
    func cornerRadius() -> CGFloat {
        var radius: CGFloat = 2
        switch self {
        case .top, .bottom:
            radius = 4
            break
        case .paddingTop, .paddingBottom:
            radius = 12
            break
        }
        return radius
    }
}
