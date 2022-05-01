//
//  SignUpViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit
import MV_Components

final class SignUpViewController: UIViewController {
    
    private let signUpContent             = MVSecondaryLabel(textAlignment: .left, fontSize: 16, textColor: #colorLiteral(red: 0.6117647059, green: 0.6117647059, blue: 0.6117647059, alpha: 1))
    
    private let stackView                 = UIStackView()
    private let appleView                 = UIView()
    private let googleView                = UIView()
            
    private let nameLabel                 = MVSecondaryLabel(textAlignment: .left, fontSize: 21, textColor: .white)
    private let emailLabel                = MVSecondaryLabel(textAlignment: .left, fontSize: 21, textColor: .white)
    private let passwordLabel             = MVSecondaryLabel(textAlignment: .left, fontSize: 21, textColor: .white)
    
    private let nameTextField             = MVSignUpTextFields(placeHolder: "Enter your name")
    private let emailTextField            = MVSignUpTextFields(placeHolder: "Enter you email")
    private let passwordTextField         = MVSignUpTextFields(placeHolder: "Enter you password.")

    private let passwordVisibiltyButton   = MVButton(frame: .zero)
    private let createAccountButton       = MVButton(backgroundColor: #colorLiteral(red: 0.6673278213, green: 0.4603560567, blue: 0.3788063228, alpha: 1), title: "Create Account")
    private let alreadyAccountLabel       = MVSecondaryLabel(textAlignment: .center, fontSize: 20, textColor: #colorLiteral(red: 0.6117647059, green: 0.6117647059, blue: 0.6117647059, alpha: 1))
    private let alreadyAccountLoginButton = MVButton(frame: .zero)
    
    var homePresenter: HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

extension SignUpViewController {
    
    private func configure() {
        configureViewController()
        configureContent()
        configureUIElements()
        configureViews()
        configureStackView()
        configureNameElements()
        configureEmailElements()
        configurePasswordElements()
        configurePasswordVisibilty()
        configureCreateButton()
        configureAlreadyAccount()
    }
    
    private func configureViewController() {
        view.backgroundColor = #colorLiteral(red: 0.1202597097, green: 0.1102947071, blue: 0.174954325, alpha: 1)
    }
    
    private func configureContent() {
        view.addSubview(signUpContent)
        
        signUpContent.text = "Sign up with one of following options"
        
        NSLayoutConstraint.activate([
            signUpContent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            signUpContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            signUpContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            signUpContent.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureViews() {
        [appleView, googleView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.cornerRadius = 10
            $0.backgroundColor    = #colorLiteral(red: 0.2078431373, green: 0.2039215686, blue: 0.2509803922, alpha: 1)
            
            NSLayoutConstraint.activate([
                $0.heightAnchor.constraint(equalToConstant: 60),
                $0.widthAnchor.constraint(equalToConstant: 160)
            ])
        }
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.frame        = view.bounds
        stackView.spacing      = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
                
        [appleView, googleView].forEach { stackView.addArrangedSubview($0) }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: signUpContent.bottomAnchor, constant: 42),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            stackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configureNameElements() {
        [nameLabel, nameTextField].forEach { view.addSubview($0) }
        nameLabel.text = "Name"
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 48),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            nameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            nameTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func configureEmailElements() {
        [emailLabel, emailTextField].forEach { view.addSubview($0) }
        emailLabel.text = "Email"
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            emailLabel.heightAnchor.constraint(equalToConstant: 25),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            emailTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func configurePasswordElements() {
        [passwordLabel, passwordTextField].forEach { view.addSubview($0) }
        passwordTextField.isSecureTextEntry = true
        passwordLabel.text                  = "Password"
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            passwordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            passwordLabel.heightAnchor.constraint(equalToConstant: 25),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func configurePasswordVisibilty() {
        passwordVisibiltyButton.tintColor = #colorLiteral(red: 0.6139065027, green: 0.6139065027, blue: 0.6139065623, alpha: 1)
        passwordVisibiltyButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        passwordVisibiltyButton.addTarget(self, action: #selector(changePasswordVisibilty), for: .touchUpInside)
        
        view.addSubview(passwordVisibiltyButton)
       
        NSLayoutConstraint.activate([
            passwordVisibiltyButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordVisibiltyButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -16),
            passwordVisibiltyButton.widthAnchor.constraint(equalToConstant: 30),
            passwordVisibiltyButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureCreateButton() {
        view.addSubview(createAccountButton)
        createAccountButton.addTarget(self,
                                      action: #selector(createAccountTapped),
                                      for: .touchUpInside)
        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 53),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            createAccountButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }

    private func configureAlreadyAccountLabel() {
        alreadyAccountLabel.text = "Already have an account?"
    }
    
    private func configureAlreadyAccountButton() {
        alreadyAccountLoginButton.setTitle("Login",
                                           for: .normal)
        alreadyAccountLoginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18,
                                                                       weight: .bold)
        alreadyAccountLoginButton.addTarget(self, action: #selector(userDidLoginButton),
                                            for: .touchUpInside)
    }
    
    private func configureAlreadyAccount() {
        let stackView            = UIStackView()
        stackView.axis           = .horizontal
        stackView.distribution   = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
                
        configureAlreadyAccountLabel()
        configureAlreadyAccountButton()
        
        [alreadyAccountLabel,
         alreadyAccountLoginButton
        ].forEach { stackView.addArrangedSubview($0) }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 53),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -68),
            stackView.heightAnchor.constraint(equalToConstant: 25),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -72)
        ])
    }
        
    private func configureUIElements() {
        let signUpAppleViewController  = SignUpAppleViewController(delegate: self)
        let signUpGoogleViewController = SignUpGoogleViewController(delegate: self)
        
        add(childVC: signUpAppleViewController, to: appleView)
        add(childVC: signUpGoogleViewController, to: googleView)
    }
}

// MARK: - UI Helpers
extension SignUpViewController {
    
    private func add(childVC: UIViewController,
                     to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

// MARK: - Button Tapped
extension SignUpViewController {
    
    @objc
    private func createAccountTapped() {}
    
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
    private func userDidLoginButton() {}
}

// MARK: - Sign Up With Apple Protocol
extension SignUpViewController: SignUpWithAppleDelegate {
    
    func userDidTappedSignUpWithApple() {
        print("did tapped sign up with apple.")
    }
}

// MARK: - Sign Up With Google Protocol
extension SignUpViewController: SignUpWithGoogleDelegate {
    
    func userDidTappedSignUpWithGoogle() {
        print("did tapped sign up with google")
    }
}
