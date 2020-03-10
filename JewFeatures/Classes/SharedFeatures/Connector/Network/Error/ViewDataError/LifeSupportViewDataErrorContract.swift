//
//  LifeSupportViewDataErrorContract.swift
//  LifeSupport
//
//  Created by Joao Gabriel Medeiros Perei on 06/02/20.
//

import Foundation


public enum JEWErrorMessages: String {

    case errorApiDefaultMessage = "Ops! Desculpe-nos. Estamos melhorando nossos serviços. Tente novamente mais tarde."
    case errorApiTimeout = "Ocorreu um problema durante o processamento. Pedimos que você consulte sua conta-corrente para verificar se a operação foi realizada"
    case errorApiNotConnectedToInternet = "Você está sem conexão com a internet!\nVerifique a conexão do seu celular e tente acessar novamente."
    case errorApiSessionTimeOut = "Seu acesso expirou. Identifique-se novamente para continuar"
    case errorApiEmptySecurityData = "Para realizar essa transação é necessário cadastrar neste aparelho o iToken no aplicativo. Acesse o menu serviços > segurança > iToken no aplicativo."
    case errorApiSimultaneousSession = "Não foi possível completar o acesso, pois existe uma sessão ativa. Aguarde alguns minutos e tente novamente."
}

public class JEWViewDataErrorContract: JEWViewDataErrorContractProtocol {
    public var error: ConnectorError
    
    public var errorDescription: String {
        return getErrorDescription()
    }
    
    public var alertType: LifeSupportAlertType {
        return getAlertType()
    }
    
    public init(error: ConnectorError) {
        self.error = error
    }
    
}


public protocol JEWViewDataErrorContractProtocol {
    var error: ConnectorError { get set }
    
    var errorDescription: String { get }
    
    var alertType: LifeSupportAlertType { get }
}

extension JEWViewDataErrorContractProtocol {
    public func getErrorDescription() -> String {
        switch error {
        case .knownApiFailures(let error):
            return getKnownApiFailuresErrorDescription(error: error)
        case .knownApiInformalFailures:
            return JEWErrorMessages.errorApiDefaultMessage.rawValue
        case .knownApiRedirections:
            return JEWErrorMessages.errorApiDefaultMessage.rawValue
        case .knownApiClientErrors:
            return JEWErrorMessages.errorApiDefaultMessage.rawValue
        case .knownApiServerErrors:
            return JEWErrorMessages.errorApiDefaultMessage.rawValue
        case .parserError:
            return JEWErrorMessages.errorApiDefaultMessage.rawValue
        }
    }
    
    internal func getKnownApiFailuresErrorDescription(error: ConnectorError.Enums.KnownApiFailures) -> String {
        switch error {
        case .invalidParams(_):
            return JEWErrorMessages.errorApiDefaultMessage.rawValue
        case .failure(_):
            return JEWErrorMessages.errorApiDefaultMessage.rawValue
        case .invalidResponse(_):
            return JEWErrorMessages.errorApiDefaultMessage.rawValue
        case .clientOrServerError(_):
            return JEWErrorMessages.errorApiDefaultMessage.rawValue
        case .nonDataClientOrServerError(_):
            return JEWErrorMessages.errorApiDefaultMessage.rawValue
        case .noFlowErrorCode(_):
            return JEWErrorMessages.errorApiDefaultMessage.rawValue
        case .noInternetErrorCode(_):
            return JEWErrorMessages.errorApiNotConnectedToInternet.rawValue
        case .emptySecurityData(_):
            return JEWErrorMessages.errorApiEmptySecurityData.rawValue
        case .idleSessionTimeout(_):
            return JEWErrorMessages.errorApiSessionTimeOut.rawValue
        case .sessionTimeout(_):
            return JEWErrorMessages.errorApiSessionTimeOut.rawValue
        case .sdkTimeout(_):
            return JEWErrorMessages.errorApiTimeout.rawValue
        case .requestTimeout(_):
            return JEWErrorMessages.errorApiTimeout.rawValue
        case .requestFailedForbidden(_):
            return JEWErrorMessages.errorApiDefaultMessage.rawValue
        }
    }
    
    internal func getAlertType() -> LifeSupportAlertType {
        switch error {
        case .knownApiFailures:
            return .error
        case .knownApiInformalFailures:
            return .error
        case .knownApiRedirections:
            return .error
        case .knownApiClientErrors:
            return .error
        case .knownApiServerErrors:
            return .error
        case .parserError:
            return .error
        }
    }
}
