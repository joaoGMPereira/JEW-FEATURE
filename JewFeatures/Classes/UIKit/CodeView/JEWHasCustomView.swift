//
//  HasCustomView.swift
//  JEWFeatures
//
//  Created by Joao Gabriel on 19/06/2020.
//  Copyright © 2020 Renan Silveira. All rights reserved.
//

import UIKit

/// Protocol to specifiy when a controller has a mainView with a custom class
/// use with typealias = <CustomView>
public protocol JEWHasCustomView: AnyObject {
    associatedtype JEWCustomView

    var customView: JEWCustomView { get }
}

public extension JEWHasCustomView where Self: UIViewController {
    var customView: JEWCustomView {
        guard let customView = view as? JEWCustomView else {
            fatalError("Could not cast Custom View")
        }

        return customView
    }
}
