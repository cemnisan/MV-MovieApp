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
        [emailLabel,
         emailTextField
        ].forEach {
            view.addSubview($0)
            $0.configureConstraints(leading: (view.leadingAnchor, 22),
                                    trailing: (view.trailingAnchor, -22))
        }
        emailLabel.configureConstraints(top: (appleView.bottomAnchor, 45))
        emailLabel.configureHeight(height: 25)
        
        emailTextField.configureConstraints(top: (emailLabel.bottomAnchor, 10))
        emailTextField.configureHeight(height: 55)
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
