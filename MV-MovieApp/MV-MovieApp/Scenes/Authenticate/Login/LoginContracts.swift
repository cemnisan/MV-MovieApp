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
    var delegate: LoginInteractorOutput? { get set }
    
    func loginWithGoogle(presenterViewController presenter: UIViewController)
    func login(with email: String, password: String) 
}

protocol LoginInteractorOutput: AnyObject {
    func displayLoadingIndicator()
    func dismissLoadingIndicator()
    func showError(error: Error)
    func showHome()
}

// MARK: - Presenter
protocol LoginPresenterProtocol: AnyObject {
    func loginWithGoogle(presenterViewController presenter: UIViewController)
    func login(with email: String, password: String)
    func userTappedRegisterButton()
}

protocol LoginPresenterOutput: AnyObject {
    func displayLoadingIndicator()
    func dismissLoadingIndicator()
    func showError(error: Error)
}

// MARK: - Router
protocol LoginRouterProtocol: AnyObject {
    func navigate(to route: LoginRoute)
}

enum LoginRoute {
    case home
    case register
}
