//
//  SignUpViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit
import MV_Components

final class SignUpViewController: UIViewController {
    
    private let signUpContent             = MVSecondaryLabel(textAlignment: .left, fontSize: 16, textColor: #colorLiteral(red: 0.6117647059, green: 0.6117647059, blue: 0.6117647059, alpha: 1), text: "Sign up with one of following options")
    
    private let appleView                 = MVContainerView(backgroundColor: #colorLiteral(red: 0.2078431373, green: 0.2039215686, blue: 0.2509803922, alpha: 1))
    private let googleView                = MVContainerView(backgroundColor: #colorLiteral(red: 0.2078431373, green: 0.2039215686, blue: 0.2509803922, alpha: 1))
    
    private let nameLabel                 = MVSecondaryLabel(textAlignment: .left, fontSize: 21, textColor: .white, text: "Name")
    private let emailLabel                = MVSecondaryLabel(textAlignment: .left, fontSize: 21, textColor: .white, text: "Email")
    private let passwordLabel             = MVSecondaryLabel(textAlignment: .left, fontSize: 21, textColor: .white, text: "Password")
    
    private let nameTextField             = MVSignUpTextFields(placeHolder: "Enter your name")
    private let emailTextField            = MVSignUpTextFields(placeHolder: "Enter you email")
    private let passwordTextField         = MVSignUpTextFields(placeHolder: "Enter you password.")
    
    private let passwordVisibiltyButton   = MVButton(frame: .zero)
    private let createAccountButton       = MVButton(backgroundColor: #colorLiteral(red: 0.6673278213, green: 0.4603560567, blue: 0.3788063228, alpha: 1), title: "Create Account")
    private let alreadyAccountLabel       = MVSecondaryLabel(textAlignment: .center, fontSize: 20, textColor: #colorLiteral(red: 0.6117647059, green: 0.6117647059, blue: 0.6117647059, alpha: 1), text: "Already have an account?")
    private let alreadyAccountLoginButton = MVButton(frame: .zero)
        
    var signUpPresenter: SignUpPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    deinit {
        print("sign up de init")
    }
}

// MARK: - Configure
extension SignUpViewController {
    
    // MARK: - All configuration
    private func configureUI() {
        configureViewController()
        configureContent()
        configureChildViews()
        configureNameElements()
        configureEmailElements()
        configurePasswordElements()
        configurePasswordVisibilty()
        configureCreateButton()
        layoutAlreadyAccount()
    }
    
    // MARK: - Configure View Controller
    private func configureViewController() {
        view.backgroundColor = #colorLiteral(red: 0.1202597097, green: 0.1102947071, blue: 0.174954325, alpha: 1)
        title                = "Register"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Configure Content
    private func configureContent() {
        view.addSubview(signUpContent)
                
        NSLayoutConstraint.activate([
            signUpContent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            signUpContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            signUpContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            signUpContent.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // MARK: - Configure Apple/Google Views
    private func configureChildViews() {
        [appleView, googleView].forEach {
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
            stackView.topAnchor.constraint(equalTo: signUpContent.bottomAnchor, constant: 42),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            stackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func addChildElements() {
        let signUpAppleViewController  = AuthAppleViewController(delegate: self)
        let signUpGoogleViewController = AuthGoogleViewController(delegate: self)
        
        add(childVC: signUpAppleViewController, to: appleView)
        add(childVC: signUpGoogleViewController, to: googleView)
    }
    
    // MARK: - Configure Name Elements
    private func configureNameElements() {
        [nameLabel, nameTextField].forEach {
            view.addSubview($0)
            
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22)
            ])
        }
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: appleView.bottomAnchor, constant: 48),
            nameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            nameTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
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
            emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
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
    
    // MARK: - Configure Visibility
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
    
    // MARK: - Configure Create Account Button
    private func configureCreateButton() {
        createAccountButton.addTarget(self,
                                      action: #selector(createAccountTapped),
                                      for: .touchUpInside)
        view.addSubview(createAccountButton)
        
        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 53),
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            createAccountButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    // MARK: - Configure Already Account
    private func configureAlreadyAccountButton() {
        alreadyAccountLoginButton.setTitle("Login",
                                           for: .normal)
        alreadyAccountLoginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18,
                                                                       weight: .bold)
        alreadyAccountLoginButton.addTarget(self, action: #selector(userDidLoginButton),
                                            for: .touchUpInside)
    }
    
    private func layoutAlreadyAccount() {
        let stackView            = UIStackView()
        stackView.axis           = .horizontal
        stackView.distribution   = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        configureAlreadyAccountButton()
        
        [alreadyAccountLabel,
         alreadyAccountLoginButton
        ].forEach { stackView.addArrangedSubview($0) }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 72),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 53),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -68)
        ])
    }
}

// MARK: - Button Tapped
extension SignUpViewController {
    
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
    private func createAccountTapped() {}
    
    @objc
    private func userDidLoginButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Sign Up View Protocol
extension SignUpViewController: SignUpViewProtocol {}

// MARK: - Sign Up With Apple - Protocol
extension SignUpViewController: AuthAppleDelegate {
    func userDidAuthWithApple() {}
}

// MARK: - Sign Up With Google - Protocol
extension SignUpViewController: AuthGoogleDelegate {
    func userDidAuthWithGoogle() {}
}
