//
//  LoginUpViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit
import MV_Components

final class LoginUpViewController: BaseAuthViewController {
    
    var loginUpPresenter: LoginUpPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setUIElements(on: .login)
    }
    
    override func addChildElements() {
        let loginUpWithAppleViewController  = AuthAppleViewController(delegate: self)
        let loginUpWithGoogleViewController = AuthGoogleViewController(delegate: self)
        
        add(childVC: loginUpWithAppleViewController, to: appleView)
        add(childVC: loginUpWithGoogleViewController, to: googleView)
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
        loginUpPresenter.userDidTappedSignUpButton()
    }
}

// MARK: - Configure
extension LoginUpViewController {
    
    // MARK: - All Configuration
    private func configureUI() {
        configureViewController()
        configureScreenDescriptionLabel()
        configureChildViews()
        configureEmailElements()
        configurePasswordElements()
        configurePasswordVisibilty()
        configureActionButton()
        layoutAccount()
    }
    
    // MARK: - Configure View Controller
    private func configureViewController() {
        view.backgroundColor = #colorLiteral(red: 0.1202597097, green: 0.1102947071, blue: 0.174954325, alpha: 1)
        title                = "Login"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

// MARK: - Login Up View Protocol
extension LoginUpViewController: LoginUpViewProtocol {}

// MARK: - Login With Apple
extension LoginUpViewController: AuthAppleDelegate {
    func userDidAuthWithApple() {}
}

// MARK: - Login with Google
extension LoginUpViewController: AuthGoogleDelegate {
    func userDidAuthWithGoogle() {}
}
