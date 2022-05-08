//
//  SignUpContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import Foundation

// MARK: - Register Interactor
protocol RegisterInteractorProtocol: BaseAuthenticateInteractorProtocol {
    var delegate: RegisterInteractorOutput? { get set }
    
    func register(with username: String, email: String, password: String)
}

// MARK: - Register Interactor Output
protocol RegisterInteractorOutput: BaseInteractorOutput {}

// MARK: - Register Presenter
protocol RegisterPresenterProtocol: BasePresenterProtocol {
    func register(username: String, email: String, password: String)
}

// MARK: - Register Presenter Output
protocol RegisterPresenterOutput: BasePresenterOutput {}

// MARK: - Register Navigator
protocol RegisterRouterProtocol: AnyObject {
    func navigate(to route: RegisterRoute)
}

// MARK: - Register Route
enum RegisterRoute {
    case home
}
