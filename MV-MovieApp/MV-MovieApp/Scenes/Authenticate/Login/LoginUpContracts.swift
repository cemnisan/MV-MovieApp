//
//  LoginUpContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation

// MARK: - Interactor
protocol LoginUpInteractorProtocol: AnyObject {
    
}

protocol LoginUpInteractorDelegate: AnyObject {
    
}

enum LoginUpInteractorOutput {
    
}

// MARK: - Presenter
protocol LoginUpPresenterProtocol: AnyObject {
    func userDidTappedSignUpButton()
}

protocol LoginUpViewProtocol: AnyObject {
    
}

enum LoginUpPresenterOutput {

}

// MARK: - Router
protocol LoginUpRouterProtocol: AnyObject {
    func navigate(to route: LoginUpRoute)
}

enum LoginUpRoute {
    case signUp
}
