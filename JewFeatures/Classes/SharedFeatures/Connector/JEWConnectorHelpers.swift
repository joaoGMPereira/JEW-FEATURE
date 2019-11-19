//
//  JEWConnectorHelpers.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 22/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import UIKit

enum ConnectorRoutes {
    case signup
    case signin
    case logout
    case simulation
    case userSimulations
    case deleteSimulation
    case deleteAllSimulations
    case evaluate
    case refreshToken
    
    func getRoute() -> URL? {
        switch self {
        case .signup:
            return JEWConnector.getURL(withRoute: "/account/sign-up")
        case .signin:
            return JEWConnector.getURL(withRoute: "/account/sign-in")
        case .logout:
            return JEWConnector.getURL(withRoute: "/account/logout")
        case .simulation:
            return JEWConnector.getURL(withRoute: "/simulation/simulator")
        case .userSimulations:
            return JEWConnector.getURL(withRoute: "/simulation/simulations")
        case .deleteSimulation:
            return JEWConnector.getURL(withRoute: "/simulation/delete")
        case .deleteAllSimulations:
            return JEWConnector.getURL(withRoute: "/simulation/deleteAll")
        case .evaluate:
            return JEWConnector.getURL(withRoute: "/evaluation/evaluate")
        case .refreshToken:
            return JEWConnector.getURL(withRoute: "/account/refresh-token")
        }
    }
}

enum ConnectorErrorType: Int {
    case none
    case authentication
    case settings
    case sessionExpired
    case logout
    
}

struct ConnectorError {
    var error: ConnectorErrorType
    var title: String
    let message: String
    let shouldRetry: Bool
    
    
    init(error: ConnectorErrorType = .none, title: String = JEWFloatingTextFieldType.defaultErrorTitle(), message: String = JEWFloatingTextFieldType.defaultErrorMessage(), shouldRetry: Bool = false) {
        self.error = error
        self.title = title
        self.message = message
        self.shouldRetry = shouldRetry
    }
}

struct ApiError: Decodable {
    var error: Bool = true
    let reason: String
    static func `default`() -> ApiError {
        return ApiError(error: true, reason: JEWFloatingTextFieldType.defaultErrorMessage())
    }
}

class JEWConnectorHelpers: NSObject {
    
    static func setupAlertController(lastViewController: UIViewController, message: String, title: String) -> INVSAlertViewController {
        let errorViewController = INVSAlertViewController()
        errorViewController.setup(withHeight: 150, andWidth: 300, andCornerRadius: 8, andContentViewColor: .white)
        errorViewController.titleAlert = title
        errorViewController.messageAlert = message
        errorViewController.hasCancelButton = false
        errorViewController.view.frame = lastViewController.view.bounds
        errorViewController.modalPresentationStyle = .overCurrentContext
        errorViewController.view.backgroundColor = .clear
        lastViewController.present(errorViewController, animated: true, completion: nil)
        return errorViewController
    }
    
    static func presentErrorRememberedUserLogged(lastViewController: UIViewController, finishCompletion:@escaping(FinishResponse)) {
        let errorViewController = setupAlertController(lastViewController: lastViewController, message: JEWConstants.RefreshErrors.message.rawValue, title: JEWConstants.RefreshErrors.title.rawValue)
        errorViewController.confirmCallback = { (button) -> () in
            errorViewController.dismiss(animated: true) {
                finishCompletion()
            }
        }
    }
    
    static func presentErrorRememberedUserLogged(lastViewController: UIViewController, message: String, title: String, shouldRetry: Bool, successCompletion: @escaping(FinishResponse), errorCompletion:@escaping(FinishResponse)) {
        let errorViewController = setupAlertController(lastViewController: lastViewController, message: message, title: title)
        errorViewController.confirmCallback = { (button) -> () in
            errorViewController.dismiss(animated: true) {
                if shouldRetry == true  {
                    successCompletion()
                } else {
                    errorCompletion()
                }
            }
        }
    }
    
    static func presentErrorGoToSettingsRememberedUserLogged(lastViewController: UIViewController, message: String, title: String = JEWConstants.StartAlertViewController.title.rawValue, finishCompletion:@escaping(FinishResponse)) {
        let errorViewController = setupAlertController(lastViewController: lastViewController, message: message, title: title)
        errorViewController.confirmCallback = { (button) -> () in
            errorViewController.dismiss(animated: true) {
                finishCompletion()
            }
        }
    }
}
