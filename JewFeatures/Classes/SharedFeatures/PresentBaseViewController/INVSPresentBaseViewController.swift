//
//  PresentBaseViewController.swift
//  InvestScopio_Example
//
//  Created by Joao Medeiros Pereira on 16/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Lottie

class INVSPresentBaseViewController: UIViewController {
    var navigationBarView = UIView()
    var navigationBarTitle = "Simulação" {
        didSet {
            navigationBarLabel.text = navigationBarTitle
        }
    }
    var navigationBarTitleColor : UIColor = .INVSBlack() {
        didSet {
            navigationBarLabel.textColor = navigationBarTitleColor
        }
    }
    var closeButton = UIButton()
    var navigationBarHeight: CGFloat = 44
    private var navigationBarLabel = UILabel()
    private var contentView = UIView()
    private var shadowLayer: CAShapeLayer?
    private var heightNavigationBarConstraint = NSLayoutConstraint()
    private var topNavigationBarConstraint = NSLayoutConstraint()
    private var animatedLogoView = AnimationView()
    var closeClosure: (() -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            navigationBarHeight = view.safeAreaInsets.top + 44
            heightNavigationBarConstraint.constant = navigationBarHeight
            topNavigationBarConstraint.constant = view.safeAreaInsets.top
            UIView.animate(withDuration: 1.6) {
                self.view.layoutIfNeeded()
                self.shadowLayer = CAShapeLayer.addCorner(withShapeLayer: self.shadowLayer, withCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], withRoundedCorner: 1, andColor: .INVSLightGray(), inView: self.navigationBarView)
            }
    }
    
    @objc private func dismissViewController() {
        if let closeClosure = closeClosure {
            closeClosure()
        }
    }
    
    func showLoading() {
        UIView.animate(withDuration: 0.4) {
            self.animatedLogoView.play()
            self.navigationBarLabel.alpha = 0.0
            self.animatedLogoView.alpha = 1.0
        }
    }
    
    func hideLoading() {
        UIView.animate(withDuration: 0.6) {
            self.navigationBarLabel.alpha = 1.0
            self.animatedLogoView.alpha = 0.0
        }
    }

}

extension INVSPresentBaseViewController {
    private func buildViewHierarchy() {
        view.addSubview(navigationBarView)
        navigationBarView.addSubview(contentView)
        contentView.addSubview(closeButton)
        contentView.addSubview(navigationBarLabel)
        contentView.addSubview(animatedLogoView)
        
        navigationBarView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        navigationBarLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        animatedLogoView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        heightNavigationBarConstraint = navigationBarView.heightAnchor.constraint(equalToConstant: 0)
        topNavigationBarConstraint = contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top)
        NSLayoutConstraint.activate([
            navigationBarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            navigationBarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            navigationBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            heightNavigationBarConstraint,
            ])
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            topNavigationBarConstraint,
            contentView.heightAnchor.constraint(equalToConstant: 44),
            ])
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            closeButton.centerYAnchor.constraint(equalTo: navigationBarView.safeAreaLayoutGuide.centerYAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
            ])
        NSLayoutConstraint.activate([
            navigationBarLabel.leadingAnchor.constraint(greaterThanOrEqualTo: closeButton.safeAreaLayoutGuide.trailingAnchor, constant: 8),
            navigationBarLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -46),
            navigationBarLabel.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor, constant: 0),
            navigationBarLabel.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            ])
        
        NSLayoutConstraint.activate([
            animatedLogoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor,constant: 0),
            animatedLogoView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            animatedLogoView.heightAnchor.constraint(equalToConstant: 40),
            animatedLogoView.widthAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    private func setupAdditionalConfiguration() {
        if let closeImage = UIImage.init(named: "closeIconWhite") {
            closeButton.tintColor = .INVSBlack()
            closeButton.setImage(closeImage, for: .normal)
        } else {
            let closeTitle = NSAttributedString.init(string: "X", attributes: [NSAttributedString.Key.font : UIFont.INVSFontDefault(),NSAttributedString.Key.foregroundColor:UIColor.INVSBlack()])
            closeButton.setAttributedTitle(closeTitle, for: .normal)
        }
        closeButton.addTarget(self, action: #selector(INVSPresentBaseViewController.dismissViewController), for: .touchUpInside)
        navigationBarLabel.text = navigationBarTitle
        navigationBarLabel.textColor = .INVSBlack()
        view.backgroundColor = .INVSGray()
        navigationBarView.backgroundColor = .INVSLightGray()
        let starAnimation = Animation.named("animatedLoadingPurple")
        animatedLogoView.animation = starAnimation
        animatedLogoView.contentMode = .scaleAspectFit
        animatedLogoView.animationSpeed = 1.0
        animatedLogoView.loopMode = .loop
        animatedLogoView.alpha = 0.0
    }
    
    private func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
}

