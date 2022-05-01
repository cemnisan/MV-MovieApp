//
//  SignUpPresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import Foundation

final class SignUpPresenter {
    
    private unowned let view: SignUpViewProtocol
    private let interactor: SignUpInteractorProtocol
    private let router: SignUpRouter
    
    init(view: SignUpViewProtocol,
         interactor: SignUpInteractorProtocol,
         router: SignUpRouter) {
        self.view       = view
        self.interactor = interactor
        self.router     = router
    }
}

extension SignUpPresenter: SignUpPresenterProtocol {
    
   
}

