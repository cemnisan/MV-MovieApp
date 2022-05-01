//
//  LoginUpBuilder.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit

final class LoginUpBuilder {
    
    static func make() -> UINavigationController {
        let viewController = LoginUpViewController()
        let router         = LoginUpRouter(view: viewController)
        let interactor     = LoginUpInteractor()
        let presenter      = LoginUpPresenter(view: viewController, interactor: interactor, router: router)
        viewController.loginUpPresenter = presenter
        
        return UINavigationController(rootViewController: viewController)
    }
}
