//
//  KeyboardToolbar.swift
//  InvestEx_Example
//
//  Created by Joao Medeiros Pereira on 10/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public enum JEWKeyboardToolbarButton: Int {
    
    case ok = 0
    case cancel
    case back
    
    func createButton(target: Any?, action: Selector?) -> UIBarButtonItem {
        var button: UIBarButtonItem!
        
        switch self {
        case .ok:
            button = UIBarButtonItem(title: "Ok", style: .plain, target: target, action: action)
        case .cancel:
            button = UIBarButtonItem(title: "Cancelar", style: .plain, target: target, action: action)
        case .back:
            button = UIBarButtonItem(title: "Voltar", style: .plain, target: target, action: action)
        }
        button.tintColor = .JEWDefault()
        button.tag = rawValue
        return button
    }
    
    static func detectType(barButton: UIBarButtonItem) -> JEWKeyboardToolbarButton? {
        return JEWKeyboardToolbarButton(rawValue: barButton.tag)
    }
}

public protocol JEWKeyboardToolbarDelegate: class {
    func keyboardToolbar(button: UIBarButtonItem, type: JEWKeyboardToolbarButton, tappedIn toolbar: JEWKeyboardToolbar)
}

public class JEWKeyboardToolbar: UIToolbar {
    
    weak var toolBarDelegate: JEWKeyboardToolbarDelegate?
    
    init() {
        super.init(frame: .zero)
        barStyle = UIBarStyle.default
        isTranslucent = true
        sizeToFit()
        isUserInteractionEnabled = true
    }
    
    func setup(leftButtons: [JEWKeyboardToolbarButton] = [JEWKeyboardToolbarButton](), rightButtons: [JEWKeyboardToolbarButton] = [JEWKeyboardToolbarButton]()) {

        let leftBarButtons = leftButtons.map { (item) -> UIBarButtonItem in
            return item.createButton(target: self, action: #selector(buttonTapped))
        }
        
        let rightBarButtons = rightButtons.map { (item) -> UIBarButtonItem in
            return item.createButton(target: self, action: #selector(buttonTapped(sender:)))
        }
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        setItems(leftBarButtons + [spaceButton] + rightBarButtons, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func buttonTapped(sender: UIBarButtonItem) {
        if let type = JEWKeyboardToolbarButton.detectType(barButton: sender) {
            toolBarDelegate?.keyboardToolbar(button: sender, type: type, tappedIn: self)
        }
    }
    
}
