//
//  FirebaseErrorHandler.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 14/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import Firebase
typealias FirebaseError = (titleError:String, messageError:String, shouldHideAutomatically:Bool, popupType:INVSPopupMessageType)
enum FireBaseErrorHandler: Int {
    case codeUserDisabled = 17005
    case codeEmailAlreadyInUse = 17007
    case codeInvalidEmail = 17008
    case codeWrongPassword = 17009
    case codeUserNotFound = 17011
    case codeInvalidUserToken = 17017
    case codeWeakPassword = 17026
    
    func getFirebaseError() -> FirebaseError {
        switch self {
        case .codeUserDisabled:
            return FirebaseError(titleError: INVSFloatingTextFieldType.defaultErrorTitle(), messageError: "Email desativado!", shouldHideAutomatically: true, popupType:.error)
        case .codeEmailAlreadyInUse:
            return FirebaseError(titleError: INVSFloatingTextFieldType.defaultErrorTitle(), messageError: "Este email já está sendo usado por outro usuário!", shouldHideAutomatically: true, popupType:.error)
        case .codeInvalidEmail:
            return FirebaseError(titleError: INVSFloatingTextFieldType.defaultErrorTitle(), messageError: "Email inválido!", shouldHideAutomatically: true, popupType:.error)
        case .codeWrongPassword:
            return FirebaseError(titleError: INVSFloatingTextFieldType.defaultErrorTitle(), messageError: "Senha incorreta!", shouldHideAutomatically: true, popupType:.error)
        case .codeUserNotFound:
            return FirebaseError(titleError: INVSFloatingTextFieldType.defaultErrorTitle(), messageError: "Email não cadastrado!", shouldHideAutomatically: true, popupType:.error)
        case .codeInvalidUserToken:
            return FirebaseError(titleError: INVSFloatingTextFieldType.defaultErrorTitle(), messageError: "Tente logar novamente em breve!", shouldHideAutomatically: true, popupType:.error)
        case .codeWeakPassword:
            return FirebaseError(titleError: INVSFloatingTextFieldType.defaultErrorTitle(), messageError: "Sua senha deve ter pelo menos 6 caracteres!", shouldHideAutomatically: true, popupType:.error)
        }
        
    }
}
