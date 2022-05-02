//
//  LoginContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation

// MARK: - Interactor
protocol LoginInteractorProtocol: AnyObject {}
protocol LoginInteractorDelegate: AnyObject {}
enum LoginInteractorOutput {}

// MARK: - Presenter
protocol LoginPresenterProtocol: AnyObject {
    func userDidTappedRegisterButton()
}

protocol LoginViewProtocol: AnyObject {}
enum LoginPresenterOutput {}

// MARK: - Router
protocol LoginRouterProtocol: AnyObject {
    func navigate(to route: LoginRoute)
}

enum LoginRoute { case register }
