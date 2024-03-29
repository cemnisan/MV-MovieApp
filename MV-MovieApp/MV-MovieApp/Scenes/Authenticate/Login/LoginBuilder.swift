//
//  LoginBuilder.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit

final class LoginBuilder {
    
    static func make() -> UINavigationController {
        let viewController              = LoginViewController()
        let router                      = LoginRouter(view: viewController)
        let interactor                  = LoginInteractor(loginService: GoogleAuthenticatorAdapter(),
                                                          fireStoreService: GoogleFireStoreAdapter())
        let presenter                   = LoginPresenter(view: viewController,
                                                         interactor: interactor,
                                                         router: router)
        viewController.loginPresenter = presenter
        
        return UINavigationController(rootViewController: viewController)
    }
}
