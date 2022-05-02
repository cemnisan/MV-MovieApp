//
//  SignUpContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import Foundation

// MARK: - Interactor
protocol RegisterInteractorProtocol: AnyObject {}
protocol RegisterInteractorDelegate: AnyObject {}
enum RegisterInteractorOutput {}

// MARK: - Presenter
protocol RegisterPresenterProtocol: AnyObject {}
protocol RegisterViewProtocol: AnyObject {}
protocol RegisterPresenterOutput {}

// MARK: - Router
protocol RegisterRouterProtocol: AnyObject {
    func navigate(to route: RegisterUpRoute)
}

enum RegisterUpRoute {}
