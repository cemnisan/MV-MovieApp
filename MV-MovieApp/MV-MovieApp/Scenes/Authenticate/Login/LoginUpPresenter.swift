//
//  LoginUpPresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation

final class LoginUpPresenter {
    
    private unowned let view: LoginUpViewProtocol
    private let interactor: LoginUpInteractorProtocol
    private let router: LoginUpRouterProtocol
    
    init(view: LoginUpViewProtocol,
         interactor: LoginUpInteractorProtocol,
         router: LoginUpRouterProtocol) {
        self.view       = view
        self.interactor = interactor
        self.router     = router
    }
}

extension LoginUpPresenter: LoginUpPresenterProtocol {
    
    func userDidTappedSignUpButton() {
        router.navigate(to: .signUp)
    }
}
