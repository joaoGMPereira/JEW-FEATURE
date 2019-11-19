//
//  INVSConstants.swift
//  InvestScopio_Example
//
//  Created by Joao Medeiros Pereira on 14/05/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import LocalAuthentication

enum JEWConstants {
    enum RefreshErrors: String {
        case title = "Atenção"
        case message = "A autenticação falhou, entre novamente."
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
