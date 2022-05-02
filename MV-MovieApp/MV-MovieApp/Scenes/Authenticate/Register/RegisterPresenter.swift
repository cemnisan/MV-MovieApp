//
//  RegisterPresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import Foundation

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
    }
}

extension RegisterPresenter: RegisterPresenterProtocol {
    
   
}

