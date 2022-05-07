//
//  LoginContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation
import UIKit.UIViewController

// MARK: - Interactor
protocol LoginInteractorProtocol: AnyObject {
    var delegate: LoginInteractorDelegate? { get set }
    
    func loginWithGoogle(presenterViewController presenter: UIViewController)
    func login(with email: String, password: String)
}

protocol LoginInteractorDelegate: AnyObject {
    func handleOutput(_ output: LoginInteractorOutput)
}

enum LoginInteractorOutput {
    case setLoading(Bool)
    case showHomePage(UserPresentation)
    case setError(Error)
}

// MARK: - Presenter
protocol LoginPresenterProtocol: AnyObject {
    func loginWithGoogle(presenterViewController presenter: UIViewController)
    func login(with email: String, password: String)
    func userTappedRegisterButton()
}

protocol LoginViewProtocol: AnyObject {
    func handleOutput(_ output: LoginPresenterOutput)
}

enum LoginPresenterOutput {
    case setLoginLoading(Bool)
    case setError(Error)
}

// MARK: - Router
protocol LoginRouterProtocol: AnyObject {
    func navigate(to route: LoginRoute)
}

enum LoginRoute {
    case home(UserPresentation)
    case register
}
