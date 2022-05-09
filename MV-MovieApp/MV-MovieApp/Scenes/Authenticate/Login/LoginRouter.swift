//
//  LoginRouter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation

final class LoginRouter: BaseAuthenticateRouter, LoginRoute {
    
    func toRegister() {
        let registerView = RegisterBuilder.make()
        view.navigationController?.show(registerView, sender: true)
    }
}
