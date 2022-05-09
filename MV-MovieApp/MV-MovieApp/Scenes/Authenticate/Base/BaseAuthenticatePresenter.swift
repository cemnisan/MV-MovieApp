//
//  BaseAuthenticatePresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 9.05.2022.
//

import Foundation
import UIKit.UIViewController

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
        self.interactor.loginWithGoogle(presenterController: presenter)
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
