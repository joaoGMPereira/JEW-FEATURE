//
//  JEWFloatingTextFieldFactory.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 19/10/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import UIKit

public enum JEWFloatingTextFieldFactoryTypes {
    case CodeView
    case InfoButton
    case format(builder: JEWFloatingTextFieldFormatBuilder)
    case toolbar(builder: JEWToolbarBuilder)
    func build(withFloatingTextField textField: JEWFloatingTextField) -> JEWFloatingTextFieldBuilderProtocol {
        switch self {
        case .CodeView:
            return JEWFloatingTextFieldCodeViewBuilder.init(with: textField)
        case .InfoButton:
            return JEWFloatingTextFieldInfoButtonBuilder.init(with: textField)
        case .format(let builder):
            return builder
        case .toolbar(let builder):
            return builder
        }
    }
}

public class JEWFloatingTextFieldFactory: NSObject {
    var textField: JEWFloatingTextField
    public init(withFloatingTextField textField: JEWFloatingTextField) {
        self.textField = textField
    }
    
    @discardableResult public func setup(buildersType: [JEWFloatingTextFieldFactoryTypes], delegate: JEWFloatingTextFieldDelegate) -> JEWFloatingTextFieldFactory {
        textField.delegate = delegate
        setupBuilders(withFloatingTextField: textField, buildersType: buildersType)
        return self
    }
    
    private func setupBuilders(withFloatingTextField textField: JEWFloatingTextField, buildersType: [JEWFloatingTextFieldFactoryTypes]) {
        for builderType in buildersType {
            let builder = builderType.build(withFloatingTextField: textField)
            builder.setup()
        }
    }
}
