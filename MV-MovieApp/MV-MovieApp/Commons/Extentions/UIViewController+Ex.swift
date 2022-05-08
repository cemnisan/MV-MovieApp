//
//  UIViewController+Ex.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import UIKit
import MV_Components

extension UIViewController {
    
    func addSubviews(views: UIView...) {
        views.forEach { view.addSubview($0) }
    }
    
    func showErrorAlert(with title: String,
                                   message: String,
                                   buttonTitle: String) {
        DispatchQueue.main.async {
            let alert = MVErrorAlertController(alertTitle: title,
                                               alertMessage: message,
                                               alertButtonTitle: buttonTitle)
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle   = .crossDissolve
            
            self.present(alert, animated: true)
        }
    }
}
