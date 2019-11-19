//
//  INVSConnectorErrorProtocol.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 02/07/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation

protocol JEWConnectorErrorProtocol {
    func displayErrorDefault(titleError: String, messageError:String, shouldHideAutomatically: Bool, popupType: INVSPopupMessageType)
    func displayErrorAuthentication(titleError: String, messageError: String, shouldRetry: Bool)
    func displayErrorSettings(titleError: String, messageError: String)
    func displayErrorLogout(titleError: String, messageError: String)
}
