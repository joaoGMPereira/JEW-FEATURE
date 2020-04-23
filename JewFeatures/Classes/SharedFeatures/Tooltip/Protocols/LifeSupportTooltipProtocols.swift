//
//  LifeSupportTooltipViewProtocols.swift
//  LifeSupport
//
//  Created by Joao Gabriel Medeiros Perei on 09/02/20.
//

import Foundation

protocol LifeSupportTooltipProtocol {
    // * Exibir o Tooltip usando as opções do TooltipConfig com os métodos de completion.
    // *
    // * @param superview UIView tela onde o tooltip será adicionado. Não pode ser nil.
    // * @param component UIView tela onde o tooltip será ancorado. Não pode ser nil.
    // * @param config IMCTooltipConfig objeto com as configurações de exibição do tooltip.
    func show(withSuperview superview: UIView, anchorView: UIView, config: LifeSupportTooltipConfig)
    
    // * Exibir o Tooltip usando as opções do TooltipConfig com os métodos de completion.
    // *
    // * @param superview UIView tela onde o tooltip será adicionado. Não pode ser nil.
    // * @param component UIView tela onde o tooltip será ancorado. Não pode ser nil.
    // * @param config IMCTooltipConfig objeto com as configurações de exibição do tooltip.
    // * @param completionShow bloco de callback para informar quando o tooltip acabou de ser exibido.
    // * @param completionDismiss bloco de callback para informar quando o tooltip acabou de ser removido.
    // */
    func show(withSuperview superview: UIView, anchorView: UIView, config: LifeSupportTooltipConfig, showCompletion: LifeSupportTooltipCompletion?, dismissCompletion: LifeSupportTooltipCompletion?)
    
    ///**
    // Dismiss existing tooltip
    //
    func dismiss(animated: Bool)
}

protocol LifeSupportTooltipSetupProtocol {
    func show(animated: Bool)
    
    func setup()
    
    func setupTooltipView(withFrame frame: CGRect) -> UIControl
    
    
    func configure(withTooltipView tooltipView: UIControl, config: LifeSupportTooltipConfig)
    func setupMessageLabel(withFrame frame: CGRect) -> UILabel
    
    func configure(withMessageLabel messageLabel: UILabel, config: LifeSupportTooltipConfig)
    
    func arrowView(withFrame frame: CGRect) -> UIView
    
    func configure(withArrowView arrowView: UIView)
    
}

protocol LifeSupportTooltipConfigProtocol {
    // * Changes configuration. If tooltip is shown it will be reloaded with the new configuration.
    // * @param config The configuration
    // */
    func changeConfig(config: LifeSupportTooltipConfig)
    
    ///**
    // * Recupera a instância do IMCTooltipConfig
    // */
    func currentConfiguration() -> LifeSupportTooltipConfig?
    
    func reloadTooltip()
    
}

protocol LifeSupportTooltipTextProtocol {
    func hasValid(string: String) -> Bool
    func hasValidTitle() -> Bool
    func hasValidText() -> Bool
    func attributedStringFullText() -> NSAttributedString
}

protocol LifeSupportTooltipCalculationProtocol {
  
    func tooltipRect() -> CGRect
    
    func hypotenuse() -> CGFloat
    
    func minWidth() -> CGFloat
    
    func maxWidth() -> CGFloat
    
    func messageRect() -> CGRect
    
    func leftTopPositionArrowRect() -> CGRect
    
    func rightTopPositionArrowRect() -> CGRect
    
    func leftBottomPositionArrowRect() -> CGRect
    
    func rightBottomPositionArrowRect() -> CGRect
    
    func centerBottomPositionArrowRect() -> CGRect
    
    func centerTopPositionArrowRect() -> CGRect
    
    func arrowViewRect() -> CGRect
}

protocol LifeSupportTooltipAnimationProtocol {
    func showTooltip(animated: Bool)
    
    func finishShow()
    
    func dismissTooltip(animated: Bool)
    
    func finishDismiss()
}
