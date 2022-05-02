//
//  AuthBaseViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import UIKit
import MV_Components

class BaseAuthViewController: UIViewController {
    
    private let screenDescriptionLabel    = MVSecondaryLabel(textAlignment: .left, fontSize: 16, textColor: K.Auth.globalColor, text: nil)
    
    let appleView                         = MVContainerView(backgroundColor: K.Auth.childViewsColor)
    let googleView                        = MVContainerView(backgroundColor: K.Auth.childViewsColor)
              
    let emailLabel                        = MVSecondaryLabel(textAlignment: .left, fontSize: 24, textColor: K.Auth.labelTextColor, text: K.Auth.emailLabel)
    let emailTextField                    = MVSignUpTextFields(placeHolder: K.Auth.emailTextField)
    
    private let passwordLabel             = MVSecondaryLabel(textAlignment: .left, fontSize: 24, textColor:  K.Auth.labelTextColor, text: K.Auth.passwordLabel)
    private let passwordTextField         = MVSignUpTextFields(placeHolder: K.Auth.passwordTextField)
    private let passwordVisibilityButton  = MVButton(frame: .zero)

    private let actionButton              = MVButton(backgroundColor: K.Auth.actionButtonColor, title: nil)
    private let accountLabel              = MVSecondaryLabel(textAlignment: .center, fontSize: 20, textColor: K.Auth.globalColor, text: nil)
    private let accountActionButton       = MVButton(frame: .zero)
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Add
extension BaseAuthViewController {
    
    func addElements() {
        addSubviews(views: screenDescriptionLabel,
                    passwordLabel,
                    passwordTextField,
                    appleView,
                    googleView,
                    passwordVisibilityButton,
                    actionButton)
    }
}

// MARK: - Configure
extension BaseAuthViewController {

    // MARK: - Configure Screen Desc.
    func configureScreenDescriptionLabel() {
        NSLayoutConstraint.activate([
            screenDescriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            screenDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            screenDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            screenDescriptionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // MARK: - Configure Password Elements
    func configurePasswordElements() {
        passwordTextField.isSecureTextEntry = true
        
        [passwordLabel, passwordTextField].forEach {
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
    
    // MARK: - Configure Apple/Google View
    func configureChildViews() {
        [appleView, googleView].forEach {
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
    
    // MARK: - Configure Password Visibility
    func configurePasswordVisibilty() {
        passwordVisibilityButton.tintColor = K.Auth.globalColor
        passwordVisibilityButton.setImage(K.Auth.passwordInvisible, for: .normal)
        passwordVisibilityButton.addTarget(self, action: #selector(changePasswordVisibility), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            passwordVisibilityButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordVisibilityButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -16),
            passwordVisibilityButton.widthAnchor.constraint(equalToConstant: 30),
            passwordVisibilityButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // MARK: - Configure Login or Register Button
    func configureActionButton() {
        actionButton.addTarget(self, action: #selector(userTappedActionButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 53),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            actionButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    // MARK: - Layout Already or don't account.
    func layoutAccount() {
        let stackView            = UIStackView()
        stackView.axis           = .horizontal
        stackView.distribution   = .fill
        stackView.spacing        = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        accountActionButton.addTarget(self, action: #selector(userTappedAccountActionButton), for: .touchUpInside)
        
        [accountLabel,
         accountActionButton
        ].forEach { stackView.addArrangedSubview($0) }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 72),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 53),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -68),
            stackView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

}

// MARK: - Set UI
extension BaseAuthViewController {
    
    func setUIElements(on controller: SelectAuthController) {
        switch controller {
        case .login:
            screenDescriptionLabel.text = K.Auth.loginScreenTitle
            accountLabel.text           = K.Auth.loginAccountLabel
            actionButton.setTitle(K.Auth.loginActionButton, for: .normal)
            accountActionButton.setTitle(K.Auth.loginAccountActionButton, for: .normal)
        case .signup:
            screenDescriptionLabel.text = K.Auth.registerScreenTitle
            accountLabel.text           = K.Auth.registerAccountLabel
            actionButton.setTitle(K.Auth.registerActionButton, for: .normal)
            accountActionButton.setTitle(K.Auth.registerAccountActionButton, for: .normal)
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
}

// MARK: - Button Tapped
extension BaseAuthViewController {
    
    @objc
    func changePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        
        switch passwordTextField.isSecureTextEntry {
        case true:
            passwordVisibilityButton.setImage(K.Auth.passwordInvisible, for: .normal)
        case false:
            passwordVisibilityButton.setImage(K.Auth.passwordVisible, for: .normal)
        }
    }
}

// MARK: - Overriding
extension BaseAuthViewController {
    
    @objc
    /// Override to set constraints of Email Label and Email Text Field
    func configureEmailElements() {}
    
    @objc
    /// Override to show apple/google views on the screen and set their delegates.
    func addChildElements() {}
    
    @objc
    /// Override for Login or Register action
    func userTappedActionButton() {}
    
    @objc
    /// Override it if the user doesn't have an account / already an account
    func userTappedAccountActionButton() {}
}
