//
//  LoginUpViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit
import MV_Components

final class LoginUpViewController: UIViewController {
    
    private let loginContentLabel        = MVSecondaryLabel(textAlignment: .left, fontSize: 16, textColor: #colorLiteral(red: 0.6117647059, green: 0.6117647059, blue: 0.6117647059, alpha: 1), text: "Log in with one of following options")
    
    private let appleView                = MVContainerView(backgroundColor: #colorLiteral(red: 0.2078431373, green: 0.2039215686, blue: 0.2509803922, alpha: 1))
    private let googleView               = MVContainerView(backgroundColor: #colorLiteral(red: 0.2078431373, green: 0.2039215686, blue: 0.2509803922, alpha: 1))
         
    private let emailLabel               = MVSecondaryLabel(textAlignment: .left, fontSize: 24, textColor: .white, text: "Email")
    private let emailTextField           = MVSignUpTextFields(placeHolder: "Enter your email")
    private let passwordLabel            = MVSecondaryLabel(textAlignment: .left, fontSize: 24, textColor: .white, text: "Password")
    private let passwordTextField        = MVSignUpTextFields(placeHolder: "Enter you password")
    private let passwordVisibiltyButton  = MVButton(frame: .zero)
    
    private let loginButton              = MVButton(backgroundColor: #colorLiteral(red: 0.6673278213, green: 0.4603560567, blue: 0.3788063228, alpha: 1), title: "Log in ")
    private let noAccountLabel           = MVSecondaryLabel(textAlignment: .center, fontSize: 20, textColor: #colorLiteral(red: 0.6117647059, green: 0.6117647059, blue: 0.6117647059, alpha: 1), text: "Don't have an account?")
    private let noAccountLoginButton     = MVButton(frame: .zero)
    
    var loginUpPresenter: LoginUpPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    deinit {
        print("login up de init")
    }
}

// MARK: - Configure
extension LoginUpViewController {
    
    // MARK: - All Configuration
    private func configureUI() {
        configureViewController()
        configureLoginContentLabel()
        configureChildViews()
        configureEmailElements()
        configurePasswordElements()
        configurePasswordVisibilty()
        configureLoginButton()
        layoutNoAccount()
    }
    
    // MARK: - Configure View Controller
    private func configureViewController() {
        view.backgroundColor = #colorLiteral(red: 0.1202597097, green: 0.1102947071, blue: 0.174954325, alpha: 1)
        title                = "Login"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    // MARK: - Configure Content
    private func configureLoginContentLabel() {
        
        view.addSubview(loginContentLabel)
        
        NSLayoutConstraint.activate([
            loginContentLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            loginContentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            loginContentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            loginContentLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // MARK: - Configure Apple/Google Login
    private func configureChildViews() {
        [appleView, googleView].forEach {
            view.addSubview($0)
            
            NSLayoutConstraint.activate([
                $0.heightAnchor.constraint(equalToConstant: 60),
                $0.widthAnchor.constraint(equalToConstant: 160)
            ])
        }
        
        layoutChildViews()
        addChildElements()
    }
    
    private func layoutChildViews() {
        let stackView          = UIStackView()
        stackView.axis         = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [appleView, googleView].forEach { stackView.addArrangedSubview($0) }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: loginContentLabel.bottomAnchor, constant: 42),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            stackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func addChildElements() {
        let loginUpWithAppleViewController  = AuthAppleViewController(delegate: self)
        let loginUpWithGoogleViewController = AuthGoogleViewController(delegate: self)
        
        add(childVC: loginUpWithAppleViewController, to: appleView)
        add(childVC: loginUpWithGoogleViewController, to: googleView)
    }
    
    // MARK: - Configure Email Elements
    private func configureEmailElements() {
        [emailLabel, emailTextField].forEach {
            view.addSubview($0)
            
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22)
            ])
        }
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: appleView.bottomAnchor, constant: 48),
            emailLabel.heightAnchor.constraint(equalToConstant: 25),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            emailTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    // MARK: - Configure Password Elements
    private func configurePasswordElements() {
        passwordTextField.isSecureTextEntry = true
        
        [passwordLabel, passwordTextField].forEach {
            view.addSubview($0)
            
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22)
            ])
        }
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            passwordLabel.heightAnchor.constraint(equalToConstant: 25),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func configureVisibiltyButton() {
        passwordVisibiltyButton.tintColor = #colorLiteral(red: 0.6139065027, green: 0.6139065027, blue: 0.6139065623, alpha: 1)
        passwordVisibiltyButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        passwordVisibiltyButton.addTarget(self, action: #selector(changePasswordVisibilty), for: .touchUpInside)
    }
    
    private func configurePasswordVisibilty() {
        configureVisibiltyButton()
        
        view.addSubview(passwordVisibiltyButton)
        
        NSLayoutConstraint.activate([
            passwordVisibiltyButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordVisibiltyButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -16),
            passwordVisibiltyButton.widthAnchor.constraint(equalToConstant: 30),
            passwordVisibiltyButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // MARK: - Configure Login Button
    private func configureLoginButton() {
        loginButton.addTarget(self, action: #selector(userTappedLoginButton), for: .touchUpInside)
        
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 53),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            loginButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    // MARK: - Configure No Account
    private func layoutNoAccount() {
        let stackView            = UIStackView()
        stackView.axis           = .horizontal
        stackView.distribution   = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        noAccountLoginButton.setTitle("Sign Up", for: .normal)
        noAccountLoginButton.addTarget(self, action: #selector(userTappedSignUpButton), for: .touchUpInside)
        
        [noAccountLabel,
         noAccountLoginButton
        ].forEach { stackView.addArrangedSubview($0) }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 72),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 53),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -68)
        ])
    }
}

// MARK: - Button Tapped
extension LoginUpViewController {
    
    @objc
    private func changePasswordVisibilty() {
        passwordTextField.isSecureTextEntry.toggle()
        
        switch passwordTextField.isSecureTextEntry {
        case true:
            passwordVisibiltyButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        case false:
            passwordVisibiltyButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    @objc
    private func userTappedLoginButton() {
        print("login")
    }
    
    @objc
    private func userTappedSignUpButton() {
        loginUpPresenter.userDidTappedSignUpButton()
    }
}

extension LoginUpViewController: LoginUpViewProtocol {
    
}

// MARK: - Login With Apple
extension LoginUpViewController: AuthAppleDelegate {
    
    func userDidAuthWithApple() {
        print("login up with apple")
    }
}

// MARK: - Login with Google
extension LoginUpViewController: AuthGoogleDelegate {
    
    func userDidAuthWithGoogle() {
        print("login up with google")
    }
}
