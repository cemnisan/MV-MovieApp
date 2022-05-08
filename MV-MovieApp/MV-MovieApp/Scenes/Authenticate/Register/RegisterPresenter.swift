//
//  RegisterPresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import Foundation
import UIKit.UIViewController

final class RegisterPresenter {
    
    private unowned let view: RegisterPresenterOutput
    private let interactor: RegisterInteractorProtocol
    private let router: RegisterRoute
    
    init(view: RegisterPresenterOutput,
         interactor: RegisterInteractorProtocol,
         router: RegisterRoute) {
        self.view       = view
        self.interactor = interactor
        self.router     = router
        
        self.interactor.delegate = self
    }
}

extension RegisterPresenter: RegisterPresenterProtocol {
    
    func loginWithGoogle(presenterViewController presenter: UIViewController) {
        interactor.loginWithGoogle(presenterController: presenter)
    }
    
    func register(username: String,email: String, password: String) {
        interactor.register(with: username, email: email, password: password)
    }
}

extension RegisterPresenter: RegisterInteractorOutput {
    
    func showError(error: Error) {
        view.showError(error: error)
    }
    
    func displayLoadingIndicator() {
        view.displayLoadingIndicator()
    }
    
    func dismissLoadingIndicator() {
        view.dismissLoadingIndicator()
    }
    
    func showHome() {
        router.toHome()
    }
}
