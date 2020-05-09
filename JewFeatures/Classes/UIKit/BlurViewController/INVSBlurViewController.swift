//
//  INVSBlurViewController.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 15/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import UIKit

public class INVSBlurViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var axysYConstraint: NSLayoutConstraint!
    
    var height: CGFloat? = nil
    var width: CGFloat? = nil
    var axysY: CGFloat? = nil
    var cornerRadius: CGFloat = 0
    var color: UIColor = .white
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        if contentView != nil && widthConstraint != nil && heightConstraint != nil && axysYConstraint != nil {
            if let height = height {
                heightConstraint.constant = height
            }
            if let width = width {
                widthConstraint.constant = width
            }
            if let axysY = axysY {
                axysYConstraint.constant = axysY
            }
            self.view.layoutIfNeeded()
            self.contentView.backgroundColor = .clear
            contentView.round(radius: cornerRadius, backgroundColor: color, withShadow: true)
        }
        // Do any additional setup after loading the view.
    }
    public func setup(withHeight height:CGFloat? = nil, andWidth width:CGFloat? = nil, andAxysY axysY:CGFloat? = nil, andCornerRadius cornerRadius: CGFloat? = nil, andContentViewColor color: UIColor = .white) {
        self.color = color
        if let cornerRadius = cornerRadius {
            self.cornerRadius = cornerRadius
        }
        if let height = height {
            self.height = height
        }
        if let width = width {
            self.width = width
        }
        if let axysY = axysY {
            self.axysY = axysY
        }
    }

}
