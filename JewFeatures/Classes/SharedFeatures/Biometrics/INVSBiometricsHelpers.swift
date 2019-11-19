//
//  INVSBiometricsHelpers.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 22/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import LocalAuthentication

let kBiometryNotAvailableReason = "Autenticação de biometria não está disponível neste iPhone."
let kSessionExpiredTitle = "Sessão Expirada!"
let kSessionExpiredMessage = "Para que continue usando o app\nsem que deslogue, salve seus Dados. "

enum BioMetricsTouchIDErrors: String {
    //Touch ID
    case kTouchIdAuthenticationReason = "Confirme sua digital para autenticar."
    case kTouchIdPasscodeAuthenticationReason = "Touch ID está bloqueado agora, porque muitas tentativas falharam. Digite sua senha para desbloquear o Touch ID."
    
    /// Error Messages Touch ID
    case kSetPasscodeToUseTouchID = "Por favor digite sua senha para usar Touche ID para autenticação."
    case kNoFingerprintEnrolled = "Não tem nenhuma digital cadastrada no iPhone. Por favor vá para: Ajustes -> Touch ID & Código e cadastre suas digitais."
    case kDefaultTouchIDAuthenticationFailedReason = "O Touch ID não reconhece a sua digital. Por favor tente novamente com a sua digital cadastrada."
    case kDefaultTouchIDErrorAuthentication = "Não foi possível autenticar seu Touch ID."
    
}

enum BioMetricsFaceIDErrors: String{
    //Face ID
    case kFaceIdAuthenticationReason = "Confirme sua face para autenticar."
    case kFaceIdPasscodeAuthenticationReason = "Face ID está bloqueado agora, porque muitas tentativas falharam. Digite sua senha para desbloquear o Face ID."
    
    // Error Messages Face ID
    case kSetPasscodeToUseFaceID = "Por favor digite sua senha para usar Face ID para autenticação."
    case kNoFaceIdentityEnrolled = "Não tem nenhuma face cadastrada no iPhone. Por favor vá para: Ajustes -> Face ID & Código e cadastre sua face."
    case kDefaultFaceIDAuthenticationFailedReason = "O Face ID não reconhece a sua face. Por favor tente novamente com a sua face cadastrada."
    case kDefaultFaceIDErrorAuthentication = "Não foi possível autenticar seu Face ID."
}


public enum AuthenticationError {
    
    case failed, canceledByUser, fallback, canceledBySystem, passcodeNotSet, biometryNotAvailable, biometryNotEnrolled, biometryLockedout, other, sessionExpired
    
    public static func initWithError(_ error: LAError) -> AuthenticationError {
        switch Int32(error.errorCode) {
            
        case kLAErrorAuthenticationFailed:
            return failed
        case kLAErrorUserCancel:
            return canceledByUser
        case kLAErrorUserFallback:
            return fallback
        case kLAErrorSystemCancel:
            return canceledBySystem
        case kLAErrorPasscodeNotSet:
            return passcodeNotSet
        case kLAErrorBiometryNotAvailable:
            return biometryNotAvailable
        case kLAErrorBiometryNotEnrolled:
            return biometryNotEnrolled
        case kLAErrorBiometryLockout:
            return biometryLockedout
        default:
            return other
        }
    }
    
    public func title() -> String {
        switch self {
        case .sessionExpired:
            return kSessionExpiredTitle
        default:
            return "Atenção"
        }
    }
    
    // get error message based on type
    public func message() -> String {
        let authentication = INVSBiometrics.shared
        
        switch self {
        case .canceledByUser, .fallback, .canceledBySystem:
            return "Tente novamente mais tarde."
        case .passcodeNotSet:
            return authentication.faceIDAvailable() ? BioMetricsFaceIDErrors.kSetPasscodeToUseFaceID.rawValue : BioMetricsTouchIDErrors.kSetPasscodeToUseTouchID.rawValue
        case .biometryNotAvailable:
            return kBiometryNotAvailableReason
        case .biometryNotEnrolled:
            return authentication.faceIDAvailable() ? BioMetricsFaceIDErrors.kNoFaceIdentityEnrolled.rawValue : BioMetricsTouchIDErrors.kNoFingerprintEnrolled.rawValue
        case .biometryLockedout:
            return authentication.faceIDAvailable() ? BioMetricsFaceIDErrors.kFaceIdPasscodeAuthenticationReason.rawValue : BioMetricsTouchIDErrors.kTouchIdPasscodeAuthenticationReason.rawValue
        case .sessionExpired:
            return kSessionExpiredMessage
        default:
            return authentication.faceIDAvailable() ? BioMetricsFaceIDErrors.kDefaultFaceIDAuthenticationFailedReason.rawValue : BioMetricsTouchIDErrors.kDefaultTouchIDAuthenticationFailedReason.rawValue
        }
    }
    
    public func shouldRetry() -> Bool {
        switch self {
        case .canceledByUser, .fallback, .canceledBySystem, .passcodeNotSet, .biometryNotAvailable, .biometryNotEnrolled, .biometryLockedout, .sessionExpired:
            return false
        default:
            return true
        }
    }
}

public enum ChallengeFailureType {
    
    case `default`
    case error(error: AuthenticationError)
    case goSettings(error: AuthenticationError)
}
