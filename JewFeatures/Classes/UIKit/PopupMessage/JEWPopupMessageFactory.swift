//
//  JEWPopupMessageFactory.swift
//  JewFeatures
//
//  Created by Joao Gabriel Pereira on 16/05/20.
//

import Foundation

public class JEWPopupMessageFactory: JEWPopupMessageDelegate {
    public static let factory = JEWPopupMessageFactory()
    public var popups = [JEWPopupMessage]()
    public var isShowing = false
    
    public func showPopups() {
        if let popup = popups.first, isShowing == false {
            popup.delegate = self
            isShowing = true
            popup.show()
        }
    }
    
    
    public func didFinishDismissPopupMessage(withPopupMessage popupMessage: JEWPopupMessage) {
        if JEWPopupMessageFactory.factory.popups.count > 0 {
            JEWPopupMessageFactory.factory.popups.removeFirst()
        }
        isShowing = false
        showPopups()
    }
}
