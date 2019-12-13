//
//  JEWNPSView.swift
//  JewFeatures
//
//  Created by Joao Gabriel Medeiros Perei on 30/11/19.
//

import UIKit
import CollectionKit

public class JEWNPSView: UIView, JEWCodeView {
    
    var avaliationButtons = [NPSButton]()
    var avaliations = [Avaliation]()
    public var collectionView = CollectionView(frame: .zero)
    private var individualSelection: Bool = false
    public var hasSelectedButtonCallback: ((_ index: Int) -> ())?
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        //fatalError("init(coder:) has not been implemented")
    }
    
    public func setIndividualSelection(individualSelection: Bool) -> JEWNPSView {
        self.individualSelection = individualSelection
        return self
    }
    
    public func setup(avaliationsCount: Int) {
        for avaliationInt in 0...avaliationsCount {
            let avaliation = Avaliation(text: "\(avaliationInt)")
            avaliations.append(avaliation)
        }
        setupCollectionData()
    }
    
    public func setup(avaliations: [Avaliation]) {
        self.avaliations = avaliations
        setupCollectionData()
    }

    
    func setupCollectionData() {
        let dataSource = ArrayDataSource<Avaliation>(data: avaliations)
        let viewSource = ClosureViewSource(viewUpdater: { (npsButton: NPSButton, data: Avaliation, index: Int) in
            npsButton.tag = index
            npsButton.setup(avaliation: data)
            self.avaliationButtons.append(npsButton)
        })
        
        let sizeSource = { (index: Int, data: Avaliation, collectionSize: CGSize) -> CGSize in
            return CGSize(width: data.width, height: data.height)
        }
        
        let provider = BasicProvider(
            dataSource: dataSource,
            viewSource: viewSource,
            sizeSource: sizeSource,
            tapHandler: { context in
                if self.individualSelection {
                    self.animateSelectedButton(selectedButton: context.view)
                    return
                }
                self.animateNPSButtons(selectedButton: context.view)
        }
        )
        provider.layout = FlowLayout(spacing: 10, justifyContent: .center)
        collectionView.provider = provider
    }
    
    func animateNPSButtons(selectedButton: NPSButton) {
        self.unselectButtons()
        for avaliationButton in self.avaliationButtons {
            if avaliationButton.tag <= selectedButton.tag {
                avaliationButton.npsIsSelected = true
                self.selectButton(selectedButton: avaliationButton)
            }
        }
        callCallBack(button: selectedButton)
    }
    
    public func selectedButton(index: Int) {
        if avaliationButtons.count >= index {
            animateSelectedButton(selectedButton: avaliationButtons[index])
        }
    }
    
    func animateSelectedButton(selectedButton: NPSButton) {
        selectedButton.npsIsSelected = !selectedButton.npsIsSelected
        if selectedButton.npsIsSelected {
            selectButton(selectedButton: selectedButton)
        } else {
            unselectButton(button: selectedButton)
        }
        callCallBack(button: selectedButton)
    }
    
    func callCallBack(button: NPSButton) {
        if let hasSelectedButtonCallback = self.hasSelectedButtonCallback {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                hasSelectedButtonCallback(button.tag)
            })
        }
    }
    
    public func unselectButtons(selectIndex: Int? = nil) {
        for (index, button) in avaliationButtons.enumerated() {
            if let selectIndex = selectIndex {
                if index != selectIndex {
                    button.npsIsSelected = false
                    unselectButton(button: button)
                }
            } else {
                button.npsIsSelected = false
                unselectButton(button: button)
            }
        }
    }
    
    public func unselectButton(indexButton: Int) {
        for (index, button) in avaliationButtons.enumerated() {
            if index == indexButton {
                button.npsIsSelected = false
                unselectButton(button: button)
            }
        }
    }
    
    func unselectButton(button: NPSButton) {
        button.setTitleColor(.JEWDefault(), for: .normal)
        button.animateBorderLayerColor(toColor: .JEWDefault(), duration: 0.2)
        button.animateBackgroundLayerColor(toColor: .clear, duration: 0.2)
    }
    func selectButton(selectedButton: NPSButton) {
        selectedButton.setTitleColor(.white, for: .normal)
        selectedButton.animateBorderLayerColor(toColor: .JEWDefault(), duration: 0.2)
        selectedButton.animateBackgroundLayerColor(toColor: .JEWDefault(), duration: 0.2)
    }
    
    public func buildViewHierarchy() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)])
    }
    
    public func setupAdditionalConfiguration() {
        
    }
}

class NPSButton: UIButton {
    let size: CGFloat = 35
    var npsIsSelected: Bool = false
    var heightConstraint = NSLayoutConstraint()
    var widthConstraint = NSLayoutConstraint()
    func setup(avaliation: Avaliation) {
        isUserInteractionEnabled = false
        setTitle(avaliation.text, for: .normal)
        backgroundColor = .clear
        layer.borderWidth = 2
        layer.masksToBounds = false
        layer.borderColor = UIColor.JEWDefault().cgColor
        setTitleColor(UIColor.JEWDefault(), for: .normal)
        layer.cornerRadius = size/2
        clipsToBounds = true
    }
}

public struct Avaliation {
    public let text: String
    public let width: CGFloat
    public let height: CGFloat
    
    public init(text: String, width: CGFloat = 35, height: CGFloat = 35) {
        self.text = text
        self.width = width
        self.height = height
    }
}
