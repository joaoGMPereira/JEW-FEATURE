//
//  JEWFloatingTextFieldType.swift
//  InvestScopio_Example
//
//  Created by Joao Medeiros Pereira on 13/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

enum JEWFloatingTextFieldType: Int {
    
    case initialValue = 0
    case monthValue
    case interestRate
    case totalMonths
    case initialMonthlyRescue
    case increaseRescue
    case goalIncreaseRescue
    case email
    case password
    case confirmPassword
    
    func setupTextField(withTextField textfield: JEWFloatingTextField,keyboardType: UIKeyboardType = .numberPad, andDelegate delegate: JEWFloatingTextFieldDelegate, valueTypeTextField: JEWFloatingTextFieldValueType, isRequired: Bool = false, hasInfoButton: Bool = false, leftButtons: [JEWKeyboardToolbarButton] = [.cancel]) {
        textfield.setup(placeholder: self.getTextFieldTitle(), typeTextField: self, valueTypeTextField: valueTypeTextField, keyboardType: keyboardType, required: isRequired, hasInfoButton: hasInfoButton, color: UIColor.JEWDefault(), leftButtons: leftButtons)
        textfield.delegate = delegate
    }
    
    func getTextFieldTitle() -> String {
        switch self {
        case .initialValue:
            return "Valor Inicial"
        case .monthValue:
            return "Investimento Mensal"
        case .interestRate:
            return "Taxa de Juros"
        case .totalMonths:
            return "Total de Meses"
        case .initialMonthlyRescue:
            return "Valor Inicial para Resgatar do seu rendimento"
        case .increaseRescue:
            return "Acréscimo no resgate"
        case .goalIncreaseRescue:
            return "Objetivo de rendimento para aumento de resgate"
        case .email:
            return "Email"
        case .password:
            return "Senha"
        case .confirmPassword:
            return "Confirmar Senha"
        }
    }
    
    func getMessageInfo() -> String {
        switch self {
        case .initialValue:
        return ""
        case .monthValue:
        return ""
        case .interestRate:
        return ""
        case .totalMonths:
        return ""
        case .initialMonthlyRescue:
        return "É o valor inicial para começar o resgate do seu rendimento.\n\nExemplo: Seu rendimento está em R$10,00 e o valor de resgate inicial é de R$1,00, portanto nesse mês você terá como resultado:\nRendimento: R$9,00 Resgate: R$1,00"
        case .increaseRescue:
            return "Exemplos:\n\n 1º Caso: 0 valor que será aumentado no resgate todo mês, caso não tenha colocado um objetivo de rendimento para aumento no resgate.\n\nExemplo:\nSeu acréscimo de resgate é de R$10,00 neste mês no próximo será R$20,00 e assim sucessivamente.\n\n 2º Caso: Toda vez que você atingir o objetivo de rendimento o valor será aumentado.\n\nExemplo:\nSeu acréscimo de resgate é de R$10,00, seu valor inicial é de R$100,00, seu objetivo é de mais R$100,00, então quando seu rendimento chegar em R$200,00, seu resgate será de mais R$10,00."
        case .goalIncreaseRescue:
            return "É o próximo valor que você espera que seu rendimento chegue para que possa aumentar o valor de resgate do mesmo.\n\nExemplo: Seu rendimento está em R$100,00 e seu resgate é de R$10,00, seu objetivo é de R$100,00 e seu acréscimo no resgate é de R$10,00, quando seu rendimento chegar em R$200,00, seu resgate será de R$20,00.\n\nOBS: Caso seu seu valor investido esteja alto o suficiente para que de um mês para o outro aumente R$200,00, R$300,00 e assim por diante, seu aumento no resgate será proporcional a ele R$20,00, R$30,00 e assim por diante."
        case .email:
            return "Digite um email válido!"
        case .password:
            return "Senha inválida!"
        case .confirmPassword:
            return "Sua senha e confirmação não são as mesmas."
        }
        
    }
    
    func getTitleMessageInfo() -> String {
        switch self {
        case .initialValue:
            return ""
        case .monthValue:
            return ""
        case .interestRate:
            return ""
        case .totalMonths:
            return ""
        case .initialMonthlyRescue:
            return "Valor Inicial do Resgate\n\n"
        case .increaseRescue:
            return "Acréscimo no Resgate\n\n"
        case .goalIncreaseRescue:
            return "Objetivo de Rendimento para aumento de resgate\n\n"
        case .email:
            return "Atenção\n"
        case .password:
            return "Atenção\n"
        case .confirmPassword:
            return "Atenção\n"
        }
    }
    
    func getNext(allTextFields: [JEWFloatingTextField]) -> JEWFloatingTextField? {
        return allTextFields.filter({$0.typeTextField == self.next()}).first
    }
    
    func next() -> JEWFloatingTextFieldType? {
        return JEWFloatingTextFieldType(rawValue: rawValue + 1)
    }
    
    static func defaultErrorTitle() -> String {
        return "Atenção\n"
    }
    
    static func defaultErrorMessage() -> String {
        return "Ocorreu algum problema,\nIremos resolver em breve."
    }
}
