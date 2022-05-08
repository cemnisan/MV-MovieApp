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
    private let router: RegisterRouter
    
    init(view: RegisterPresenterOutput,
         interactor: RegisterInteractorProtocol,
         router: RegisterRouter) {
        self.view       = view
        self.interactor = interactor
        self.router     = router
        
        self.interactor.delegate = self
    }
}

extension RegisterPresenter: RegisterPresenterProtocol {
    
    func loginWithGoogle(presenterViewController presenter: UIViewController) {
        interactor.loginWithGoogle(presenterViewController: presenter)
    }
    
    func register(username: String,
                  email: String,
                  password: String) {
        interactor.register(with: username,
                            email: email,
                            password: password)
    }
}

extension RegisterPresenter: RegisterInteractorOutput {
    
    func showError(error: Error) {
        view.showError(error: error)
    }
    
    func displayIndicatorView() {
        view.displayIndicatorView()
    }
    
    func dismissIndicatorView() {
        view.dismissIndicatorView()
    }
    
    func showHomePage() {
        router.navigate(to: .home)
    }
}
