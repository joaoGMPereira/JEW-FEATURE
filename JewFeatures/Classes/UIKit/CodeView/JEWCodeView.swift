//
//  CodeView.swift
//  InvestEx_Example
//
//  Created by Joao Medeiros Pereira on 10/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

public protocol JEWCodeView: class {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension JEWCodeView {
    public func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
//    
//    public func buildViewHierarchy() {
//        
//    }
//    public func setupConstraints() {
//        
//    }
//    public func setupAdditionalConfiguration() {
//        
//    }

}
