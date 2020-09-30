//
//  JEWBiometrics.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 21/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import LocalAuthentication

public typealias AuthenticationSuccess = (() -> ())
public typealias AuthenticationFailure = ((AuthenticationError) -> ())


public class JEWBiometrics: NSObject {
    public static let shared = JEWBiometrics()
    
    public class func canAuthenticate() -> Bool {
        
        var isBioMetrixAuthenticationAvailable = false
        var error: NSError? = nil
        
        if LAContext().canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            isBioMetrixAuthenticationAvailable = (error == nil)
        }
        return isBioMetrixAuthenticationAvailable
    }
    
    public class func authenticateWithBiometrics(reason: String, fallbackTitle: String? = "", cancelTitle: String? = "", success successBlock:@escaping AuthenticationSuccess, failure failureBlock:@escaping AuthenticationFailure) {
        let reasonString = reason.isEmpty ? JEWBiometrics.defaultBiometricsAuthenticationReason() : reason
        
        let context = LAContext()
        context.localizedFallbackTitle = fallbackTitle
        
        // cancel button title
        context.localizedCancelTitle = cancelTitle
        
        // authenticate
        JEWBiometrics.shared.evaluate(policy: LAPolicy.deviceOwnerAuthenticationWithBiometrics, with: context, reason: reasonString, success: successBlock, failure: failureBlock)
    }
    
    public class func authenticateWithPasscode(reason: String, cancelTitle: String? = "", success successBlock:@escaping AuthenticationSuccess, failure failureBlock:@escaping AuthenticationFailure) {
        let reasonString = reason.isEmpty ? JEWBiometrics.defaultPasscodeAuthenticationReason() : reason
        
        let context = LAContext()
        context.localizedCancelTitle = cancelTitle
        
        // authenticate
        JEWBiometrics.shared.evaluate(policy: LAPolicy.deviceOwnerAuthentication, with: context, reason: reasonString, success: successBlock, failure: failureBlock)
    }
    
    public static func faceIDAvailable() -> Bool {
        let context = LAContext()
        return (context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: nil) && context.biometryType == .faceID)
    }
    
    public static func defaultBiometricsAuthenticationReason() -> String {
        return faceIDAvailable() ? BiometricsFaceIDErrors.kFaceIdAuthenticationReason.rawValue : BiometricsTouchIDErrors.kTouchIdAuthenticationReason.rawValue
    }
    
    public static func defaultPasscodeAuthenticationReason() -> String {
        return faceIDAvailable() ? BiometricsFaceIDErrors.kFaceIdPasscodeAuthenticationReason.rawValue : BiometricsTouchIDErrors.kTouchIdPasscodeAuthenticationReason.rawValue
    }
    
    public func evaluate(policy: LAPolicy, with context: LAContext, reason: String, success successBlock:@escaping AuthenticationSuccess, failure failureBlock:@escaping AuthenticationFailure) {
        
        context.evaluatePolicy(policy, localizedReason: reason) { (success, err) in
            DispatchQueue.main.async {
                if success { successBlock() }
                else {
                    let errorType = AuthenticationError.initWithError(err as! LAError)
                    failureBlock(errorType)
                }
            }
        }
    }
}

public typealias FailureChallenge = ((_ challengeErrorType: ChallengeFailureType) -> ())
public typealias SuccessChallenge = (() -> ())

public class JEWBiometricsChallenge: NSObject {
    public static func checkLoggedUser(reason: String = "", keychainKey: String = "", successChallenge: @escaping(SuccessChallenge), failureChallenge: @escaping(FailureChallenge)) {
        let hasBiometricAuthenticationEnabled = JEWKeyChainWrapper.retrieveBool(withKey: keychainKey)
        if let hasBiometricAuthentication = hasBiometricAuthenticationEnabled, hasBiometricAuthentication == true {
            showTouchId(reason: reason,successChallenge: {
                successChallenge()
            }) { (challengeFailureType) in
                failureChallenge(challengeFailureType)
            }
        } else {
            successChallenge()
        }
    }
    
    public static func showTouchId(reason: String = "", successChallenge: @escaping(SuccessChallenge), failureChallenge: @escaping(FailureChallenge)) {
        // start authentication
        JEWBiometrics.authenticateWithBiometrics(reason: reason, success: {
            // authentication successful
            successChallenge()
        }, failure: { (error) in
            // do nothing on canceled
            if error == .canceledByUser || error == .canceledBySystem || error == .fallback  {
                failureChallenge(ChallengeFailureType.default)
                return
            }
                // device does not support biometric (face id or touch id) authentication
            else if error == .biometryNotAvailable {
                failureChallenge(ChallengeFailureType.error(error: error))
                
            }
                // No biometry enrolled in this device, ask user to register fingerprint or face
            else if error == .biometryNotEnrolled {
                failureChallenge(ChallengeFailureType.goSettings(error: error))
            }
                // Biometry is locked out now, because there were too many failed attempts.
                // Need to enter device passcode to unlock.
            else if error == .biometryLockedout {
                showPasscodeAuthentication(message: error.message(), successChallenge: {
                    successChallenge()
                }, failureChallenge: { (challengeFailureType) in
                    failureChallenge(challengeFailureType)
                })
            }
                // show error on authentication failed
            else {
                failureChallenge(ChallengeFailureType.error(error: AuthenticationError.failed))
            }
        })
    }

    // show passcode authentication
    public static func showPasscodeAuthentication(message: String, successChallenge: @escaping(SuccessChallenge), failureChallenge: @escaping(FailureChallenge)) {
        
        JEWBiometrics.authenticateWithPasscode(reason: message, success: {
            // passcode authentication success
            successChallenge()
        }) { (error) in
           failureChallenge(ChallengeFailureType.default)
        }
    }
}
