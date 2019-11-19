//
//  CodeView.swift
//  InvestEx_Example
//
//  Created by Joao Medeiros Pereira on 10/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

protocol INVSCodeView: class {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension INVSCodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
