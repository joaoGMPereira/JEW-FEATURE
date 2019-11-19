//
//  JEWConstants.swift
//  InvestScopio_Example
//
//  Created by Joao Medeiros Pereira on 14/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import LocalAuthentication

enum JEWConstants {
    enum SimulatorKeyChainConstants: String {
        case lastTotalValue = "JEWLastTotalValue"
        case lastProfitabilityUntilNextIncreaseRescue = "JEWLastProfitabilityUntilNextIncreaseRescue"
//        case lastGoalIncreaseRescue = "JEWLastGoalIncreaseRescue"
        case lastRescue = "JEWLastRescue"
    }
    
    enum SimulatorCellConstants: String {
        case cellIdentifier = "JEWSimulatorCell"
        case tableViewHeaderName = "JEWSimulatorHeaderView"
    }
    
    enum SimulationCellConstants: String {
        case cellIdentifier = "JEWSimulationCell"
    }
    
    enum JEWTransactionsViewControllersID: String {
        case startSimulatedViewController = "JEWStartSimulatedViewController"
    }
    
    enum JEWServicesConstants: String {
        case apiV1 = "https://invest-scopio-backend.herokuapp.com/api/v1"
        case apiV1Dev = "https://invest-scopio-dev-backend.herokuapp.com/api/v1"
        case localHost = "http://localhost:8080/api/v1"
        case version = "version"
    }
    
    enum SimulationErrors: String {
        case defaultTitleError = "Ocorreu um problema, Tente novamente.\n\n"
        case defaultMessageError = "Não foi possível fazer o cálculo da simulação."
    }
    
    enum RefreshErrors: String {
        case title = "Atenção"
        case message = "A autenticação falhou, entre novamente."
    }
    
    enum LoginKeyChainConstants: String {
        case hasUserLogged = "JEWHasUserLogged"
        case hasEnableBiometricAuthentication = "JEWHasEnableBiometricAuthentication"
        case lastLoginEmail = "JEWRememberMeEmail"
        case lastLoginSecurity = "JEWRememberMeSecurity"
        case hasEvaluateApp = "JEWHasEvaluatedApp"
    }
    
    enum OfflineViewController: String {
        case title = "Atenção"
        case message = "Sem efetuar o login você não terá\nacesso ao seu histórico de simulações."
    }
    
    enum StartAlertViewController: String {
        case title = "Atenção"
        case titleSettings = "Vá para Ajustes"
    }
    
    enum LogoutAlertViewController: String {
        case title = "Atenção"
        case message = "Deseja sair da sua conta?"
    }
    
    enum TalkWithUsAlertViewController: String {
        case titleError = "Atenção\n"
        case messageMailError = "Você não habilitou o serviço de enviar email pelo app."
        case messageInvalidVoteError = "Selecione uma avaliação antes de votar."
        case messageVoteError = "Não foi possível gravar seu voto. Tente novamente."
        case titleSuccess = "Obrigado\n"
        case messageMailSuccess = "Iremos te responder em breve!"
    }
    
    enum EnableBiometricViewController: String {
        case title = "Atenção"
        static func biometricMessageType() -> String {
            let authContext = LAContext()
            let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
            switch(authContext.biometryType) {
            case .none:
                return "Para sua segurança, é preciso que você autentique seu Touch ID/Face ID para que o app faça seu acesso automaticamente, com isso habilite ele vá em: Ajustes -> (Touch ID/Face ID) & Código e cadastre sua(s) (biometrias/face)."
            case .touchID:
                return "Para sua segurança, é preciso que você autentique seu Touch ID, quando entrar no app novamente, para que o app faço seu acesso automaticamente."
            case .faceID:
                return "Para sua segurança, é preciso que você autentique seu Face ID, quando entrar no app novamente, para que o app faço seu acesso automaticamente."
            @unknown default:
                return "Para sua segurança, é preciso que você autentique seu Touch ID/Face ID para que o app faça seu acesso automaticamente, com isso habilite ele vá em: Ajustes -> (Touch ID/Face ID) & Código e cadastre sua(s) (biometrias/face)."
            }
        }
    }

}
