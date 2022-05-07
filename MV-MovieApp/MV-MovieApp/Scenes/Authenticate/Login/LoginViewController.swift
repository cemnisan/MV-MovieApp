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
        setUIElements(on: .login)
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
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: appleView.bottomAnchor, constant: 30),
            emailLabel.heightAnchor.constraint(equalToConstant: 25),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            emailTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    override func userTappedActionButton() {
        print("user did tapped login button.")
    }
    
    override func userTappedAccountActionButton() {
        loginPresenter.userDidTappedRegisterButton()
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
        loginPresenter.userDidTappedLoginWithGoogle(presenterViewController: self)
    }
}

// MARK: - Login Up View Protocol
extension LoginViewController: LoginViewProtocol {
    
    func handleOutput(_ output: LoginPresenterOutput) {
        switch output {
        case .setLoginLoading(let isLoading):
            print(isLoading)
        case .setError(let error):
            print(error)
        }
    }
}
