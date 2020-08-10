//
//  XPCustomViewController.swift
//  XPCore
//
//  Created by João Pereira on 19/06/20.
//

import UIKit

open class JEWCustomViewController<JEWCustomView: JEWCustomCodeView>: UIViewController {
    // MARK: - Typealias
    public var customView: JEWCustomView {
        return view as! JEWCustomView
    }

    // MARK: - Life cycle
    open override func loadView() {
        view = JEWCustomView()
        customView.setupView()
    }
}
