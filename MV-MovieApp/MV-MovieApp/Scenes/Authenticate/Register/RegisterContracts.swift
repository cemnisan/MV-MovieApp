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
    var delegate: RegisterInteractorOutput? { get set }
    
    func loginWithGoogle(presenterViewController presenter: UIViewController)
    func register(with username: String, email: String, password: String)
}

protocol RegisterInteractorOutput: AnyObject {
    func showError(error: Error)
    func displayIndicatorView()
    func dismissIndicatorView()
    func showHomePage()
}

// MARK: - Presenter
protocol RegisterPresenterProtocol: AnyObject {
    func loginWithGoogle(presenterViewController presenter: UIViewController)
    func register(username: String, email: String, password: String)
}

protocol RegisterPresenterOutput: AnyObject {
    func showError(error: Error)
    func displayIndicatorView()
    func dismissIndicatorView()
}

// MARK: - Router
protocol RegisterRouterProtocol: AnyObject {
    func navigate(to route: RegisterRoute)
}

enum RegisterRoute {
    case home
}
