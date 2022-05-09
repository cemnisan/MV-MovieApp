//
//  RegisterPresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import Foundation
import UIKit.UIViewController

final class RegisterPresenter: BaseAuthenticatePresenter {
    
    private unowned let registerView: RegisterPresenterOutput
    private let registerInteractor: RegisterInteractorProtocol
    private let registerRouter: RegisterRoute
    
    init(view: RegisterPresenterOutput,
         interactor: RegisterInteractorProtocol,
         router: RegisterRoute) {
        self.registerView       = view
        self.registerInteractor = interactor
        self.registerRouter     = router
        
        super.init(view: view,
                   interactor: interactor,
                   router: router)
        registerInteractor.delegate = self
    }
}

extension RegisterPresenter: RegisterPresenterProtocol {
    
    func register(username: String, email: String, password: String) {
        registerInteractor.register(with: username, email: email, password: password)
    }
}

extension RegisterPresenter: RegisterInteractorOutput {}
