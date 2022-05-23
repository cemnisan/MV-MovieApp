//
//  UIViewController+Ex.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import UIKit
import MV_Components

extension UIViewController {
    
    func showAlert(
        type alertType: AlertTypes,
        title: String,
        message: String,
        buttonTitle: String,
        delegate: MVActionAlertDelegate? = nil)
    {
        DispatchQueue.main.async {
            let alert: MVAlertController
            
            switch alertType {
            case .info:
                alert = MVInfoAlertController(
                    alertTitle: title,
                    alertMessage: message,
                    alertButtonTitle: buttonTitle)
            case .action:
                alert = MVActionAlertController(
                    alertTitle: title,
                    alertMessage: message,
                    alertCancelButton: "Cancel",
                    alertDoneButtonTitle: buttonTitle,
                    delegate: delegate)
            }
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle   = .crossDissolve
            self.present(alert, animated: true)
        }
    }
}
