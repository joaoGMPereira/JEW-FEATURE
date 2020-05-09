//
//  JEWConnectorHelpers.swift
//  InvestScopio
//
//  Created by Joao Medeiros Pereira on 22/06/19.
//  Copyright © 2019 Joao Medeiros Pereira. All rights reserved.
//

import Foundation
import UIKit

public class JEWConnectorHelpers: NSObject {
    
    public static func setupAlertController(lastViewController: UIViewController, message: String, title: String, height: CGFloat = 150, width: CGFloat = 300, cornerRadius: CGFloat = 8, lottie: JEWConstants.Resources.Lotties = .animatedLoadingBlack) -> INVSAlertViewController {
        let errorViewController = INVSAlertViewController()
        errorViewController.setup(withHeight: height, andWidth: width, andCornerRadius: cornerRadius, andContentViewColor: .white)
        errorViewController.lottie = lottie
        errorViewController.titleAlert = title
        errorViewController.messageAlert = message
        errorViewController.hasCancelButton = false
        errorViewController.view.frame = lastViewController.view.bounds
        errorViewController.modalPresentationStyle = .overCurrentContext
        errorViewController.view.backgroundColor = .clear
        lastViewController.present(errorViewController, animated: true, completion: nil)
        return errorViewController
    }
    
    public static func presentErrorRememberedUserLogged(lastViewController: UIViewController, message: String = JEWConstants.RefreshErrors.message.rawValue, title: String = JEWConstants.Default.title.rawValue, height: CGFloat = 150, width: CGFloat = 300, cornerRadius: CGFloat = 8, lottie: JEWConstants.Resources.Lotties = .animatedLoadingBlack, shouldRetry: Bool = false, successCompletion: @escaping(JEWCompletion), errorCompletion:@escaping(JEWCompletion)) {
        let errorViewController = setupAlertController(lastViewController: lastViewController, message: message, title: title, height: height, width: width, cornerRadius: cornerRadius, lottie: lottie)
        
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
    
    public static func presentErrorGoToSettingsRememberedUserLogged(lastViewController: UIViewController, message: String, title: String = JEWConstants.Default.title.rawValue, height: CGFloat = 150, width: CGFloat = 300, cornerRadius: CGFloat = 8, lottie: JEWConstants.Resources.Lotties = .animatedLoadingBlack, finishCompletion:@escaping(JEWCompletion)) {
        let errorViewController = setupAlertController(lastViewController: lastViewController, message: message, title: title, height: height, width: width, cornerRadius: cornerRadius, lottie: lottie)
        
        errorViewController.confirmCallback = { (button) -> () in
            errorViewController.dismiss(animated: true) {
                finishCompletion()
            }
        }
    }
}
