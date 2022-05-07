//
//  RegisterPresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import Foundation
import UIKit.UIViewController

final class RegisterPresenter {
    
    private unowned let view: RegisterViewProtocol
    private let interactor: RegisterInteractorProtocol
    private let router: RegisterRouter
    
    init(view: RegisterViewProtocol,
         interactor: RegisterInteractorProtocol,
         router: RegisterRouter) {
        self.view       = view
        self.interactor = interactor
        self.router     = router
        
        self.interactor.delegate = self
    }
}

extension RegisterPresenter: RegisterPresenterProtocol {
    func userTappedLoginWithGoogle(presenterViewController presenter: UIViewController) {
        interactor.loginWithGoogle(presenterViewController: presenter)
    }
}

extension RegisterPresenter: RegisterInteractorDelegate {
    func handleOutput(_ output: RegisterInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            print(isLoading)
        case .showHomePage:
            router.navigate(to: .home)
        case .setError(let error):
            view.handleOutput(.setError(error))
        }
    }
}
