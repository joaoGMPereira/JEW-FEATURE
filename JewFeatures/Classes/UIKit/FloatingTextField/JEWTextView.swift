//
//  JEWTextView.swift
//  NishizakiMercados_Example
//
//  Created by Joao Gabriel Pereira on 23/06/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public protocol JEWTextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView)
    func textViewDidEndEditing(_ textView: UITextView)
    func textViewDidChange(_ textView: UITextView)
}

public class JEWTextView: UIView {
    public let textView = UITextView(frame: .zero)
    public let placeholder = UILabel(frame: .zero)
    public var jewDelegate: JEWTextViewDelegate?
    let sepator = UIView(frame: .zero)
    let clearButton = UIButton(frame: .zero)
    
    public var color: UIColor = .lightGray {
        didSet {
            updateLayout()
        }
    }
    
    public var placeholderText: String? {
        didSet {
            updateLayout()
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public func updateLayout() {
        placeholder.textColor = color
        sepator.backgroundColor = color
        placeholder.text = placeholderText
        if self.textView.text.isEmpty {
            placeholder.isAnimated(isHidden: false)
            return
        }
        placeholder.isAnimated(isHidden: true)
    }
    
}

extension JEWTextView: JEWCodeView {
    public func buildViewHierarchy() {
        addSubview(textView)
        addSubview(placeholder)
        addSubview(sepator)
        addSubview(clearButton)
        textView.translatesAutoresizingMaskIntoConstraints = false
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        sepator.translatesAutoresizingMaskIntoConstraints = false
        clearButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func setupConstraints() {
        textView.setupEdgeConstraints(parent: self, padding: 4, useSafeLayout: true)
        NSLayoutConstraint.activate([
            placeholder.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            placeholder.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            placeholder.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            sepator.leadingAnchor.constraint(equalTo: leadingAnchor),
            sepator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            sepator.trailingAnchor.constraint(equalTo: trailingAnchor),
            sepator.heightAnchor.constraint(equalToConstant: 1),
            clearButton.widthAnchor.constraint(equalToConstant: 15),
            clearButton.heightAnchor.constraint(equalTo: clearButton.widthAnchor),
            clearButton.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
            clearButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
        ])
    }
    
    public func setupAdditionalConfiguration() {
        placeholder.textColor = .lightGray
        textView.isScrollEnabled = false
        placeholder.isAnimated(isHidden: true)
        textView.delegate = self
        textView.font = placeholder.font
        textView.backgroundColor = .clear
        textView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 24)
        clearButton.setTitle("x", for: .normal)
        clearButton.backgroundColor = .lightGray
        clearButton.layer.cornerRadius = 7.5
        clearButton.titleLabel?.font = .JEW11()
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
    }
    
    @objc func clearText() {
        textView.text = String()
        updateLayout()
        jewDelegate?.textViewDidChange(textView)
    }
}

extension JEWTextView: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        jewDelegate?.textViewDidBeginEditing(textView)
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        jewDelegate?.textViewDidEndEditing(textView)
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        updateLayout()
        jewDelegate?.textViewDidChange(textView)
    }
}

extension JEWTextView: JEWKeyboardToolbarDelegate {
    public func keyboardToolbar(button: UIBarButtonItem, type: JEWKeyboardToolbarButton, tappedIn toolbar: JEWKeyboardToolbar) {
        endEditing(true)
    }
}
