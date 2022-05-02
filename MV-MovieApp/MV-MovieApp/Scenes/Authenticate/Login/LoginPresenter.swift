//
//  LoginPresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation

final class LoginPresenter {
    
    private unowned let view: LoginViewProtocol
    private let interactor: LoginInteractorProtocol
    private let router: LoginRouterProtocol
    
    init(view: LoginViewProtocol,
         interactor: LoginInteractorProtocol,
         router: LoginRouterProtocol) {
        self.view       = view
        self.interactor = interactor
        self.router     = router
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    
    func userDidTappedRegisterButton() {
        router.navigate(to: .register)
    }
}
