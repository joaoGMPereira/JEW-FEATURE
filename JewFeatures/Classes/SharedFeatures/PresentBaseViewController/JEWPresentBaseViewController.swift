//
//  PresentBaseViewController.swift
//  InvestScopio_Example
//
//  Created by Joao Medeiros Pereira on 16/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Lottie
import PodAsset

public class JEWPresentBaseViewController: UIViewController {
    public var navigationBarView = UIView()
    public var navigationBarTitle = "" {
        didSet {
            navigationBarLabel.text = navigationBarTitle
        }
    }
    public var navigationBarTitleColor : UIColor = .JEWBlack() {
        didSet {
            navigationBarLabel.textColor = navigationBarTitleColor
        }
    }
    
    public var lottie : JEWConstants.Resources.Lotties = .animatedLoadingBlack {
        didSet {
            lottieString = lottie.rawValue
        }
    }
    
    public var closeButton = UIButton()
    public var navigationBarHeight: CGFloat = 44
    private var lottieString: String = JEWConstants.Resources.Lotties.animatedLoadingBlack.rawValue
    private var navigationBarLabel = UILabel()
    private var contentView = UIView()
    private var shadowLayer: CAShapeLayer?
    private var heightNavigationBarConstraint = NSLayoutConstraint()
    private var topNavigationBarConstraint = NSLayoutConstraint()
    private var animatedLogoView = AnimationView()
    public var closeClosure: (() -> ())?
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            navigationBarHeight = view.safeAreaInsets.top + 44
            heightNavigationBarConstraint.constant = navigationBarHeight
            topNavigationBarConstraint.constant = view.safeAreaInsets.top
            UIView.animate(withDuration: 1.6) {
                self.view.layoutIfNeeded()
                self.navigationBarView.round(radius: 1, backgroundColor: .JEWLightGray(), withShadow: true)
            }
    }
    
    @objc private func dismissViewController() {
        if let closeClosure = closeClosure {
            closeClosure()
        }
    }
    
    public func showLoading() {
        UIView.animate(withDuration: 0.4) {
            self.animatedLogoView.play()
            self.navigationBarLabel.alpha = 0.0
            self.animatedLogoView.alpha = 1.0
        }
    }
    
    public func hideLoading() {
        UIView.animate(withDuration: 0.6) {
            self.navigationBarLabel.alpha = 1.0
            self.animatedLogoView.alpha = 0.0
        }
    }
    
    private func setupLottie() {
        if let bundle = PodAsset.bundle(forPod: JEWConstants.Resources.podsJewFeature.rawValue) {
            let loadingAnimation = Animation.named(lottieString, bundle: bundle)
            animatedLogoView.animation = loadingAnimation
            animatedLogoView.contentMode = .scaleAspectFit
            animatedLogoView.animationSpeed = 1.0
            animatedLogoView.loopMode = .loop
            animatedLogoView.alpha = 0.0
        }
    }

}

extension JEWPresentBaseViewController {
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
        setupExitButton()
        
        navigationBarLabel.text = navigationBarTitle
        navigationBarLabel.textColor = .JEWBlack()
        view.backgroundColor = .JEWGray()
        navigationBarView.backgroundColor = .JEWLightGray()
        setupLottie()
    }
    
    private func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    private func setupExitButton() {
        if let closeImage = UIImage.init(named: JEWConstants.Resources.Images.closeIconWhite.rawValue, in: Bundle(for: type(of: self)), compatibleWith: nil) {
            closeButton.tintColor = .JEWBlack()
            closeButton.setImage(closeImage, for: .normal)
        } else {
            let closeTitle = NSAttributedString.init(string: "X", attributes: [NSAttributedString.Key.font : UIFont.JEW14(),NSAttributedString.Key.foregroundColor:UIColor.JEWBlack()])
            closeButton.setAttributedTitle(closeTitle, for: .normal)
        }
        closeButton.addTarget(self, action: #selector(JEWPresentBaseViewController.dismissViewController), for: .touchUpInside)
    }
    
}

extension JEWPresentBaseViewController {
    public class Builder: NSObject {
        let presentBaseViewController = JEWPresentBaseViewController()
        
        public func set(navigationBarTitle: String) -> Builder {
            presentBaseViewController.navigationBarTitle = navigationBarTitle
            return self
        }
        
        public func set(navigationBarTitleColor: UIColor) -> Builder {
            presentBaseViewController.navigationBarTitleColor = navigationBarTitleColor
            return self
        }
        
        public func set(lottie: JEWConstants.Resources.Lotties) -> Builder {
            presentBaseViewController.lottie = lottie
            return self
        }
        
        public func build() -> JEWPresentBaseViewController {
            return JEWPresentBaseViewController()
        }
    }
}

