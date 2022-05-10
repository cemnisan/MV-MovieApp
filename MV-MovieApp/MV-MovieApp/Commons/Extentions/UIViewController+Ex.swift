//
//  UIViewController+Ex.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import UIKit
import MV_Components

extension UIViewController {

    func showErrorAlert(with title: String,
                        message: String,
                        buttonTitle: String) {
        DispatchQueue.main.async {
            let alert = MVInfoAlertController(alertTitle: title,
                                              alertMessage: message,
                                              alertButtonTitle: buttonTitle)
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle   = .crossDissolve
            
            self.present(alert, animated: true)
        }
    }
    
    func showActionAlert(with title: String,
                         message: String,
                         buttonTitle: String,
                         delegate: MVActionAlertDelegate) {
         DispatchQueue.main.async {
             let alert = MVActionAlertController(alertTitle: title,
                                                 alertMessage: message,
                                                 alertCancelButton: "Cancel",
                                                 alertDoneButtonTitle: buttonTitle,
                                                 delegate: delegate)
             alert.modalPresentationStyle = .overFullScreen
             alert.modalTransitionStyle   = .crossDissolve
      
             self.present(alert, animated: true)
         }
     }
}
