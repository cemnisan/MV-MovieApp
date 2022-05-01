//
//  AuthBaseViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import UIKit
import MV_Components

class BaseAuthViewController: UIViewController {
    
    let screenDescriptionLabel             = MVSecondaryLabel(textAlignment: .left, fontSize: 16, textColor: #colorLiteral(red: 0.6117647059, green: 0.6117647059, blue: 0.6117647059, alpha: 1), text: nil)
    
    let appleView                          = MVContainerView(backgroundColor: #colorLiteral(red: 0.2078431373, green: 0.2039215686, blue: 0.2509803922, alpha: 1))
    let googleView                         = MVContainerView(backgroundColor: #colorLiteral(red: 0.2078431373, green: 0.2039215686, blue: 0.2509803922, alpha: 1))
    
    let emailLabel               		   = MVSecondaryLabel(textAlignment: .left, fontSize: 24, textColor: .white, text: "Email")
    let emailTextField           		   = MVSignUpTextFields(placeHolder: "Enter your email")
    
    let passwordLabel            		   = MVSecondaryLabel(textAlignment: .left, fontSize: 24, textColor: .white, text: "Password")
    let passwordTextField        		   = MVSignUpTextFields(placeHolder: "Enter you password")
    let passwordVisibilityButton           = MVButton(frame: .zero)

    let actionButton                       = MVButton(backgroundColor: #colorLiteral(red: 0.6673278213, green: 0.4603560567, blue: 0.3788063228, alpha: 1), title: nil)
    let accountLabel                       = MVSecondaryLabel(textAlignment: .center, fontSize: 20, textColor: #colorLiteral(red: 0.6117647059, green: 0.6117647059, blue: 0.6117647059, alpha: 1), text: nil)
    let accountActionButton                = MVButton(frame: .zero)
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Configure
extension BaseAuthViewController {

    func configureScreenDescriptionLabel() {
        view.addSubview(screenDescriptionLabel)
        
        NSLayoutConstraint.activate([
            screenDescriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            screenDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            screenDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            screenDescriptionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc
    func configureEmailElements() {}
    
    // MARK: - Configure Password Elements
    func configurePasswordElements() {
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
    
    func configureChildViews() {
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
    
    func layoutChildViews() {
        let stackView          = UIStackView()
        stackView.axis         = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [appleView, googleView].forEach { stackView.addArrangedSubview($0) }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: screenDescriptionLabel.bottomAnchor, constant: 42),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            stackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureVisibilityButton() {
        passwordVisibilityButton.tintColor = #colorLiteral(red: 0.6139065027, green: 0.6139065027, blue: 0.6139065623, alpha: 1)
        passwordVisibilityButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        passwordVisibilityButton.addTarget(self, action: #selector(changePasswordVisibility), for: .touchUpInside)
    }
    
    func configurePasswordVisibilty() {
        configureVisibilityButton()
        
        view.addSubview(passwordVisibilityButton)
        
        NSLayoutConstraint.activate([
            passwordVisibilityButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordVisibilityButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -16),
            passwordVisibilityButton.widthAnchor.constraint(equalToConstant: 30),
            passwordVisibilityButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureActionButton() {
        actionButton.addTarget(self, action: #selector(userTappedActionButton), for: .touchUpInside)
        
        view.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 53),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            actionButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func layoutAccount() {
        let stackView            = UIStackView()
        stackView.axis           = .horizontal
        stackView.distribution   = .fill
        stackView.spacing        = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        accountActionButton.setTitle("Sign Up", for: .normal)
        accountActionButton.addTarget(self, action: #selector(userTappedAccountActionButton), for: .touchUpInside)
        
        [accountLabel,
         accountActionButton
        ].forEach { stackView.addArrangedSubview($0) }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 72),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 53),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -68)
        ])
    }

}

// MARK: - Set UI
extension BaseAuthViewController {
    
    func setUIElements(on controller: SelectAuthController) {
        switch controller {
        case .login:
            screenDescriptionLabel.text = "Log in with one of following options"
            accountLabel.text           = "Don’t have an account?"
            actionButton.setTitle("Log in", for: .normal)
        case .signup:
            screenDescriptionLabel.text = "Sign up with one of following options"
            accountLabel.text           = "Already have an account?"
            actionButton.setTitle("Create Account", for: .normal)
        }
    }
}

// MARK: - UI Helpers
extension BaseAuthViewController {
    
    func add(childVC: UIViewController,
              to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc
    func addChildElements() {}
}

// MARK: - Button Tapped
extension BaseAuthViewController {
    
    @objc
    func changePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        
        switch passwordTextField.isSecureTextEntry {
        case true:
            passwordVisibilityButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        case false:
            passwordVisibilityButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    @objc
    func userTappedActionButton() {}
    
    @objc
    func userTappedAccountActionButton() {}
}
