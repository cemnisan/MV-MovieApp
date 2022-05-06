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
}

protocol LoginInteractorDelegate: AnyObject {
    func handleOutput(_ output: LoginInteractorOutput)
}

enum LoginInteractorOutput {
    case setLoginLoading(Bool)
    case showHomePage(UserPresentation)
}

// MARK: - Presenter
protocol LoginPresenterProtocol: AnyObject {
    func userDidTappedLoginWithGoogle(presenterViewController presenter: UIViewController)
    func userDidTappedRegisterButton()
}

protocol LoginViewProtocol: AnyObject {
    func handleOutput(_ output: LoginPresenterOutput)
}

enum LoginPresenterOutput {
    case setLoginLoading(Bool)
}

// MARK: - Router
protocol LoginRouterProtocol: AnyObject {
    func navigate(to route: LoginRoute)
}

enum LoginRoute {
    case home(UserPresentation)
    case register
}
