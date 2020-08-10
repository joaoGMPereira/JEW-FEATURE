//
//  ChallengeOptionsView.swift
//  DailyRewards
//
//  Created by Joao Gabriel Medeiros Perei on 28/11/19.
//  Copyright © 2019 Joao Gabriel Medeiros Perei. All rights reserved.
//

import UIKit

open class ScrollableStackView: UIScrollView {
    public var stackView = UIStackView(frame: .zero)
    public var hasUpdatedLayoutCallback: ((_ width: CGFloat) -> ())?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public func setup(subViews: [UIView], axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution = .fill, spacing: CGFloat = 0, alwaysBounce: Bool = false, shouldHaveSizeOfView: Bool = false) {
        stackView.distribution = distribution
        stackView.spacing = spacing
        for subView in subViews {
            stackView.addArrangedSubview(subView)
        }
        setupAxis(axis: axis, alwaysBounce: alwaysBounce, shouldHaveSizeOfView: shouldHaveSizeOfView)
    }
    
    public func setCustomSpacing(spacing: CGFloat, after: UIView) {
        stackView.setCustomSpacing(spacing, after: after)
    }
    
    private func setupAxis(axis: NSLayoutConstraint.Axis, alwaysBounce: Bool, shouldHaveSizeOfView: Bool) {
        stackView.axis = axis
        alwaysBounceVertical = alwaysBounce
        if axis == .vertical {
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        } else {
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        }
        
        shouldScroll(axis: axis, shouldHaveSizeOfView: shouldHaveSizeOfView)
    }
    
    private func shouldScroll(axis: NSLayoutConstraint.Axis, shouldHaveSizeOfView: Bool) {
        
        UIView.animate(withDuration: 0.01, animations: {
            self.layoutIfNeeded()
        }) { (finished) in
            if shouldHaveSizeOfView {
                if axis == .vertical {
                    let shouldScroll = shouldHaveSizeOfView && self.contentSize.height < self.frame.height
                    if shouldScroll {
                        self.stackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
                    }
                } else {
                    let shouldScroll = shouldHaveSizeOfView && self.contentSize.width < self.frame.width
                    if shouldScroll {
                        self.stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
                    }
                }
            }
            self.layoutIfNeeded()
            if let hasUpdatedLayoutCallback = self.hasUpdatedLayoutCallback {
                hasUpdatedLayoutCallback(self.stackView.frame.width)
            }
        }
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
        stackView.alignment = .fill
        stackView.backgroundColor = .clear
    }
    
    
}
