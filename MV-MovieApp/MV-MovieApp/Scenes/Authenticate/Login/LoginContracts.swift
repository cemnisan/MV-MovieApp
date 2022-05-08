//
//  LoginContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation

// MARK: - Login Interactor
protocol LoginInteractorProtocol: BaseAuthenticateInteractorProtocol {
    var delegate: LoginInteractorOutput? { get set }
    
    func login(with email: String, password: String) 
}

// MARK: - Login Interactor Output
protocol LoginInteractorOutput: BaseInteractorOutput {}

// MARK: - Login Presenter
protocol LoginPresenterProtocol: BasePresenterProtocol {
    func login(with email: String, password: String)
    func userTappedRegisterButton()
}

// MARK: - Login Presenter Output
protocol LoginPresenterOutput: BasePresenterOutput {}

// MARK: - Login Navigator
protocol LoginRouterProtocol: AnyObject {
    func navigate(to route: LoginRoute)
}

// MARK: - Login Route
enum LoginRoute { case home, register }
