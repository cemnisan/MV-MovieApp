//
//  SignUpContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import Foundation
import UIKit.UIViewController

// MARK: - Interactor
protocol RegisterInteractorProtocol: AnyObject {
    var delegate: RegisterInteractorDelegate? { get set }
    
    func loginWithGoogle(presenterViewController presenter: UIViewController)
}

protocol RegisterInteractorDelegate: AnyObject {
    func handleOutput(_ output: RegisterInteractorOutput)
}

enum RegisterInteractorOutput {
    case setLoading(Bool)
    case showHomePage
    case setError(Error)
}

// MARK: - Presenter
protocol RegisterPresenterProtocol: AnyObject {
    func userTappedLoginWithGoogle(presenterViewController presenter: UIViewController)
}

protocol RegisterViewProtocol: AnyObject {
    func handleOutput(_ output: RegisterPresenterOutput)
}

enum RegisterPresenterOutput {
    case setLoading(Bool)
    case setError(Error)
}

// MARK: - Router
protocol RegisterRouterProtocol: AnyObject {
    func navigate(to route: RegisterRoute)
}

enum RegisterRoute {
    case home
}
