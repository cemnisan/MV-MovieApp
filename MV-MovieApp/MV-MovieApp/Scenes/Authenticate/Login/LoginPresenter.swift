//
//  LoginPresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation
import UIKit.UIViewController

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
        
        self.interactor.delegate = self
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    
    func loginWithGoogle(presenterViewController presenter: UIViewController) {
        interactor.loginWithGoogle(presenterViewController: presenter)
    }
    
    func login(with email: String, password: String) {
        interactor.login(with: email, password: password)
    }

    func userTappedRegisterButton() {
        router.navigate(to: .register)
    }
}

extension LoginPresenter: LoginInteractorDelegate {
    
    func handleOutput(_ output: LoginInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoginLoading(isLoading))
        case .showHomePage(let userPresentation):
            router.navigate(to: .home(userPresentation))
        case .setError(let error):
            view.handleOutput(.setError(error))
        }
    }
}
