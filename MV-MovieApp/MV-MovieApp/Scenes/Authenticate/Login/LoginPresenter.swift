//
//  LoginPresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation
import UIKit.UIViewController

final class LoginPresenter: BaseAuthenticatePresenter {
 
    private unowned let loginView: LoginPresenterOutput
    private let loginInteractor: LoginInteractorProtocol
    private let loginRouter: LoginRoute
    
    init(view: LoginPresenterOutput,
         interactor: LoginInteractorProtocol,
         router: LoginRoute) {
        self.loginView       = view
        self.loginInteractor = interactor
        self.loginRouter     = router

        super.init(view: view,
                   interactor: interactor,
                   router: router)
        loginInteractor.delegate = self
    }
}

extension LoginPresenter: LoginPresenterProtocol {

    func login(with email: String, password: String) {
        loginInteractor.login(with: email, password: password)
    }

    func userTappedRegisterButton() {
        loginRouter.toRegister()
    }
}

extension LoginPresenter: LoginInteractorOutput {}
