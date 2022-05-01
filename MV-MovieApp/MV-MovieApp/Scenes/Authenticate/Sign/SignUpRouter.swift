//
//  SignUpRouter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import UIKit

final class SignUpRouter {
    
    unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension SignUpRouter: SignUpRouterProtocol {
    
    func navigate(to route: SignUpRoute) {
            }
}
