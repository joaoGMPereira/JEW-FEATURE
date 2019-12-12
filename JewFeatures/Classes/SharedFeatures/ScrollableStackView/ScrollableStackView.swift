//
//  ChallengeOptionsView.swift
//  DailyRewards
//
//  Created by Joao Gabriel Medeiros Perei on 28/11/19.
//  Copyright © 2019 Joao Gabriel Medeiros Perei. All rights reserved.
//

import UIKit

public class ScrollableStackView: UIScrollView {
    public var stackView = UIStackView(frame: .zero)
    public var hasUpdatedLayoutCallback: ((_ width: CGFloat) -> ())?
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public func setup(subViews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0, alwaysBounce: Bool = false) {
        stackView.spacing = spacing
        setupAxis(axis: axis, alwaysBounce: alwaysBounce)
        for subView in subViews {
            stackView.addArrangedSubview(subView)
        }
        layoutIfNeeded()
        if let hasUpdatedLayoutCallback = hasUpdatedLayoutCallback {
            hasUpdatedLayoutCallback(stackView.frame.width)
        }
    }
    
    public func setCustomSpacing(spacing: CGFloat, after: UIView) {
        stackView.setCustomSpacing(spacing, after: after)
    }
    
    private func setupAxis(axis: NSLayoutConstraint.Axis, alwaysBounce: Bool) {
        stackView.axis = axis
        if axis == .vertical {
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            alwaysBounceVertical = alwaysBounce
        } else {
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
            alwaysBounceHorizontal = alwaysBounce
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ScrollableStackView: JEWCodeView {
    public func buildViewHierarchy() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func setupConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    public func setupAdditionalConfiguration() {
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = .clear
    }
    
    
}
