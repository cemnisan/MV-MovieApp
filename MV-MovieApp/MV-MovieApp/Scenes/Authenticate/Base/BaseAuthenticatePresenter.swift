//
//  BaseAuthenticatePresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 9.05.2022.
//

import UIKit
import AuthenticationServices

class BaseAuthenticatePresenter {
    
    private unowned let view: BaseAuthenticatePresenterOutput
    private let interactor: BaseAuthenticateInteractorProtocol
    private let router: BaseAuthenticateRoute
    
    init(view: BaseAuthenticatePresenterOutput,
         interactor: BaseAuthenticateInteractorProtocol,
         router:BaseAuthenticateRoute) {
        self.view           = view
        self.interactor     = interactor
        self.router         = router
        
        interactor.delegate = self
    }
}

extension BaseAuthenticatePresenter: BaseAuthenticatePresenterProtocol {
    
    func loginWithGoogle(presenterViewController presenter: UIViewController) {
        interactor.loginWithGoogle(presenterController: presenter)
    }
    
    func loginWithApple(presenterViewController presenter: BaseAuthViewController, selectedAuthController: SelectAuthController) {
        interactor.loginWithApple(presenterController: presenter, selectedAuthController: selectedAuthController)
    }
    
    func loginWithCredential(credential: ASAuthorizationAppleIDCredential) {
        interactor.loginWithCredential(credential: credential)
    }
}

extension BaseAuthenticatePresenter: BaseAuthenticateInteractorOutput {
    
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
