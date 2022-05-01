//
//  SignUpContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import Foundation

// MARK: - Interactor
protocol SignUpInteractorProtocol: AnyObject {}
protocol SignUpInteractorDelegate: AnyObject {}
enum SignUpInteractorOutput {}

// MARK: - Presenter
protocol SignUpPresenterProtocol: AnyObject {}

protocol SignUpViewProtocol: AnyObject {}
protocol SignUpPresenterOutput {}

// MARK: - Router
protocol SignUpRouterProtocol: AnyObject {
    func navigate(to route: SignUpRoute)
}

enum SignUpRoute {}
