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
    func loginWithGoogle(presenterController presenter: UIViewController)
}

// MARK: - Base Interactor Output
protocol BaseInteractorOutput: AnyObject {
    func showError(error: Error)
    func displayLoadingIndicator()
    func dismissLoadingIndicator()
    func showHome()
}

// MARK: - Base Presenter
protocol BasePresenterProtocol: AnyObject {
    func loginWithGoogle(presenterViewController presenter: UIViewController)
}

// MARK: - Base Presenter Output
protocol BasePresenterOutput: AnyObject {
    func showError(error: Error)
    func displayLoadingIndicator()
    func dismissLoadingIndicator()
}
