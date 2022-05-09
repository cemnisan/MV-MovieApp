//
//  LoginContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation

// MARK: - Login Interactor
protocol LoginInteractorProtocol: BaseAuthenticateInteractorProtocol {
    func login(with email: String, password: String) 
}

// MARK: - Login Interactor Output
protocol LoginInteractorOutput: BaseAuthenticateInteractorOutput {}

// MARK: - Login Presenter
protocol LoginPresenterProtocol: BaseAuthenticatePresenterProtocol {
    func login(with email: String, password: String)
    func userTappedRegisterButton()
}

// MARK: - Login Presenter Output
protocol LoginPresenterOutput: BaseAuthenticatePresenterOutput {}

// MARK: - Login Route
protocol LoginRoute: BaseAuthenticateRoute {
    func toRegister()
}
