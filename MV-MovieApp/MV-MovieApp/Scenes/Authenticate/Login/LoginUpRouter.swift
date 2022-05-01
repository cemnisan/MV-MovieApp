//
//  LoginUpRouter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit

final class LoginUpRouter {
    
    unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

// MARK: - Login Up Router Protocol
extension LoginUpRouter: LoginUpRouterProtocol {

    func navigate(to route: LoginUpRoute) {
        switch route {
        case .signUp:
            let signUpView = SignUpBuilder.make()
            view.navigationController?.pushViewController(signUpView, animated: true)
        }
    }
}
