//
//  LoginRouter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit

final class LoginRouter {
    
    unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

// MARK: - Login Up Router Protocol
extension LoginRouter: LoginRouterProtocol {

    func navigate(to route: LoginRoute) {
        switch route {
        case .home(let user):
            let homeView                    = HomeBuilder.make(with: user)
            homeView.modalPresentationStyle = .fullScreen
            homeView.modalTransitionStyle   = .coverVertical
            view.show(homeView, sender: nil)
        case .register:
            let registerView = RegisterBuilder.make()
            view.navigationController?.show(registerView, sender: true)
        }
    }
}
