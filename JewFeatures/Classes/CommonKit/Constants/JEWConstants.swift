//
//  JEWConstants.swift
//  InvestScopio_Example
//
//  Created by Joao Medeiros Pereira on 14/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import LocalAuthentication

public typealias JEWCompletion = () -> ()
public enum JEWConstants {
    
    public enum Services: String {
        case localHost = "http://localhost:8084/api/v1"
    }
    
    public enum Default: String {
        case title = "Atenção"
        case errorMessage = "Ocorreu algum problema,\nIremos resolver em breve."
        case invalidURL = "URL Inválida!"
        case expiredSession = "Sessão Expirada"
        case tryAgainLater = "Tente novamente mais tarde."
    }
    
    public enum RefreshErrors: String {
        case message = "A autenticação falhou, entre novamente."
        case invalidRefreshToken = "Refresh Token Inválido!"
        case invalidAccessToken = "Access Token Inválido!"
        
    }
    
    public enum LoginKeyChainConstants: String {
        case hasUserLogged = "HasUserLogged"
        case hasEnableBiometricAuthentication = "HasEnableBiometricAuthentication"
        case lastLoginEmail = "RememberMeEmail"
        case lastLoginSecurity = "RememberMeSecurity"
        case hasEvaluateApp = "HasEvaluatedApp"
    }
    
    public enum Resources: String {
        case podsJewFeature = "JewFeatures"
        public enum Images: String {
            case closeIconWhite = "closeIconWhite"
        }
        public enum Lotties: String {
            case animatedLoadingBlack = "animatedLoadingBlack"
            case animatedLoadingPurple = "animatedLoadingPurple"
            case animatedLoadingWhite = "animatedLoadingWhite"
            case closePlusAnimationPurple = "closePlusAnimationPurple"
            case refreshAnimationBlack = "refreshAnimationBlack"
            case refreshAnimationPurple = "refreshAnimationPurple"
        }
    }

    
    public enum EnableBiometric: String {
        case enableTouchId = "Habilitar Touch ID"
        case enableFaceId = "Habilitar Face ID"
        case CanceledBiometricPopup = "Por favor aceite a biometria para que possa logar"
        case EnableBiometricViewController = "EnableBiometricViewController"
        public static func biometricMessageType() -> String {
            let authContext = LAContext()
            let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
            switch(authContext.biometryType) {
            case .none:
                return "Para sua segurança, é preciso que você autentique seu Touch ID/Face ID para que o app faça seu acesso automaticamente, com isso habilite ele vá em: Ajustes -> (Touch ID/Face ID) & Código e cadastre sua(s) (biometrias/face)."
            case .touchID:
                return "Para sua segurança, é preciso que você autentique seu Touch ID, quando entrar no app novamente, para que o app faça seu acesso automaticamente."
            case .faceID:
                return "Para sua segurança, é preciso que você autentique seu Face ID, quando entrar no app novamente, para que o app faça seu acesso automaticamente."
            @unknown default:
                return "Para sua segurança, é preciso que você autentique seu Touch ID/Face ID para que o app faça seu acesso automaticamente, com isso habilite ele, vá em: Ajustes -> (Touch ID/Face ID) & Código e cadastre sua(s) (biometrias/face)."
            }
        }
    }
}
