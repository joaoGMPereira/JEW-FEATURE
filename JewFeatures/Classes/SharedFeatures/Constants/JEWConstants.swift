//
//  JEWConstants.swift
//  InvestScopio_Example
//
//  Created by Joao Medeiros Pereira on 14/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import LocalAuthentication

public enum JEWConstants {
    
    public enum Services: String {
        case localHost = "http://localhost:8080/api/v1"
        case version = "version"
        case signUp = "/account/sign-up"
        case signIn = "/account/sign-in"
        case logout = "/account/logout"
        case refreshToken = "/account/refresh-token"
    }
    
    public enum Default: String {
        case title = "Atenção"
        case errorMessage = "Ocorreu algum problema,\nIremos resolver em breve."
        case invalidURL = "URL Inválida!"
        case expiredSession = "Sessão Expirada"
    }
    
    public enum RefreshErrors: String {
        case message = "A autenticação falhou, entre novamente."
        case invalidRefreshToken = "Refresh Token Inválido!"
        case invalidAccessToken = "Access Token Inválido!"
        
    }
    
    public enum StartAlertViewController: String {
        case titleSettings = "Vá para Ajustes"
    }
    
    public enum LogoutAlertViewController: String {
        case message = "Deseja sair da sua conta?"
    }
    
    public enum EnableBiometricViewController: String {
        case EnableBiometricViewController = "EnableBiometricViewController"
        public static func biometricMessageType() -> String {
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
