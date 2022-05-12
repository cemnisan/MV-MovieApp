//
//  BaseAuthenticateContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 8.05.2022.
//

import Foundation
import UIKit.UIViewController

// MARK: - Base Interactor
protocol BaseAuthenticateInteractorProtocol: AnyObject {
    var delegate: BaseAuthenticateInteractorOutput? { get set }
    
    func loginWithGoogle(presenterController presenter: UIViewController)
}

// MARK: - Base Interactor Output
protocol BaseAuthenticateInteractorOutput: AnyObject {
    func displayLoadingIndicator()
    func dismissLoadingIndicator()
    func showError(error: Error)
    func showHome()
}

// MARK: - Base Presenter
protocol BaseAuthenticatePresenterProtocol: AnyObject {
    func loginWithGoogle(presenterViewController presenter: UIViewController)
}

// MARK: - Base Presenter Output
protocol BaseAuthenticatePresenterOutput: AnyObject {
    func displayLoadingIndicator()
    func dismissLoadingIndicator()
    func showError(error: Error)
}

// MARK: - Base Route
protocol BaseAuthenticateRoute: AnyObject {
    func toHome()
}
