//
//  LoginPresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation
import UIKit.UIViewController

final class LoginPresenter {
    
    private unowned let view: LoginPresenterOutput
    private let interactor: LoginInteractorProtocol
    private let router: LoginRouterProtocol
    
    init(view: LoginPresenterOutput,
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
        interactor.loginWithGoogle(presenterController: presenter)
    }
    
    func login(with email: String, password: String) {
        interactor.login(with: email, password: password)
    }

    func userTappedRegisterButton() {
        router.navigate(to: .register)
    }
}

extension LoginPresenter: LoginInteractorOutput {
    
    func displayLoadingIndicator() {
        view.displayLoadingIndicator()
    }
    
    func dismissLoadingIndicator() {
        view.dismissLoadingIndicator()
    }
    
    func showError(error: Error) {
        view.showError(error: error)
    }
    
    func showHome() {
        router.navigate(to: .home)
    }
}
