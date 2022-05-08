//
//  LoginUpViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit
import MV_Components

final class LoginViewController: BaseAuthViewController {
    
    var loginPresenter: LoginPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setUIElements(for: .login)
    }
    
    override func addChildElements() {
        let loginWithAppleViewController  = AuthAppleViewController(delegate: self)
        let loginWithGoogleViewController = AuthGoogleViewController(delegate: self)
        
        add(childVC: loginWithAppleViewController,  to: appleView)
        add(childVC: loginWithGoogleViewController, to: googleView)
    }
    
    override func configureEmailElements() {
        [emailLabel, emailTextField].forEach {
            view.addSubview($0)
            
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22)
            ])
        }
        
        emailTextField.text = "cnisan2132@gmail.com"
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: appleView.bottomAnchor, constant: 30),
            emailLabel.heightAnchor.constraint(equalToConstant: 25),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            emailTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    override func userDidTappedActionButton() {
        guard let email    = emailTextField.text,
              let password = passwordTextField.text else { return }
        loginPresenter.login(with: email, password: password)
    }
    
    override func userDidTappedAccountButton() {
        loginPresenter.userTappedRegisterButton()
    }
}

// MARK: - Configure
extension LoginViewController {
    
    // MARK: - All Configuration
    private func configureUI() {
        configureViewController(on: .login)
        addElements()
        configureScreenDescriptionLabel()
        configureChildViews()
        configureEmailElements()
        configurePasswordElements()
        configurePasswordVisibilty()
        configureActionButton()
        layoutAccount()
    }
}

// MARK: - Login With Apple
extension LoginViewController: AuthAppleDelegate {
    func userDidTappedAuthWithApple() {}
}

// MARK: - Login with Google
extension LoginViewController: AuthGoogleDelegate {
    
    func userDidTappedAuthWithGoogle() {
        loginPresenter.loginWithGoogle(presenterViewController: self)
    }
}

// MARK: - Login Up View Protocol
extension LoginViewController: LoginPresenterOutput {
    
    func displayLoadingIndicator() {
        actionButton.isEnabled = false
        showLoadingView()
    }
    
    func dismissLoadingIndicator() {
        actionButton.isEnabled = true
        dismissLoadingView()
    }
    
    func showError(error: Error) {
        showErrorAlert(with: "Login Error", message: error.localizedDescription, buttonTitle: "OK")
    }
}
