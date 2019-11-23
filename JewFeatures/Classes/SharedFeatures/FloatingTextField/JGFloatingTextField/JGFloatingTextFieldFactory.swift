//
//  JGFloatingTextFieldFactory.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 19/10/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import UIKit

public enum JGFloatingTextFieldFactoryTypes {
    case CodeView
    case InfoButton
    func build(withFloatingTextField textField: JGFloatingTextField) -> JGFloatingTextFieldBuilderProtocol {
        switch self {
        case .CodeView:
            return JGFloatingTextFieldCodeViewBuilder.init(with: textField)
        case .InfoButton:
            return JEWFloatingTextFieldInfoButtonBuilder.init(with: textField)
        }
    }
}

public class JGFloatingTextFieldFactory: NSObject {
    var textField: JGFloatingTextField
    public init(withFloatingTextField textField: JGFloatingTextField) {
        self.textField = textField
    }
    
    public func setup(buildersType: [JGFloatingTextFieldFactoryTypes], delegate: JGFloatingTextFieldDelegate) {
        textField.delegate = delegate
        setupBuilders(withFloatingTextField: textField, buildersType: buildersType)
    }
    
    private func setupBuilders(withFloatingTextField textField: JGFloatingTextField, buildersType: [JGFloatingTextFieldFactoryTypes], builderFormatText: JEWFloatingTextFieldFormatBuilder? = nil) {
        for builderType in buildersType {
            let builder = builderType.build(withFloatingTextField: textField)
            builder.setup()
        }
    }
    
    public func setupFormatBuilder(builder: JEWFloatingTextFieldFormatBuilder) -> JGFloatingTextFieldFactory {
        builder.setup()
        return self
    }
    
    public func setupToolbarBuilder(builder: JEWFloatingTextFieldToolbarBuilder) -> JGFloatingTextFieldFactory {
        builder.setup()
        return self
    }
}
