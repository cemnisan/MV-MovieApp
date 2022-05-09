//
//  RegisterViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit
import MV_Components

final class RegisterViewController: BaseAuthViewController {
    
    private let nameLabel     = MVSecondaryLabel(textAlignment: .left, fontSize: 21, textColor: K.Styles.labelTextColor, text: K.Auth.nameLabel)
    private let nameTextField = MVAuthenticatesTextField(placeHolder: K.Auth.nameTextField)
    
    var registerPresenter: RegisterPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setUIElements(for: .register)
    }
    
    override func addChildElements() {
        let registerWithAppleViewController  = AuthAppleViewController(delegate: self)
        let registerWithGoogleViewController = AuthGoogleViewController(delegate: self)
        
        add(childVC: registerWithAppleViewController, to: appleView)
        add(childVC: registerWithGoogleViewController, to: googleView)
    }
    
    override func configureEmailElements() {
        [emailLabel,
         emailTextField
        ].forEach {
            view.addSubview($0)
            $0.configureConstraints(leading: (view.leadingAnchor, 22),
                                    trailing: (view.trailingAnchor, -22))
        }
        emailLabel.configureConstraints(top: (nameTextField.bottomAnchor, 30))
        emailLabel.configureHeight(height: 25)
        
        emailTextField.configureConstraints(top: (emailLabel.bottomAnchor, 10))
        emailTextField.configureHeight(height: 55)
    }
    
    override func userDidTappedActionButton() {
        registerPresenter.register(username: nameTextField.text!,
                                   email: emailTextField.text!,
                                   password: passwordTextField.text!)
    }
    
    override func userDidTappedAccountButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Configure
extension RegisterViewController {
    
    // MARK: - All configuration
    private func configureUI() {
        configureViewController(on: .register)
        addElements()
        configureScreenDescriptionLabel()
        configureChildViews()
        configureNameElements()
        configureEmailElements()
        configurePasswordElements()
        configurePasswordVisibilty()
        configureActionButton()
        layoutAccount()
    }
    
    // MARK: - Configure Name Elements
    private func configureNameElements() {
        [nameLabel,
         nameTextField
        ].forEach {
            view.addSubview($0)
            $0.configureConstraints(leading: (view.leadingAnchor, 22),
                                    trailing: (view.trailingAnchor, -22))
        }
        nameLabel.configureConstraints(top: (appleView.bottomAnchor, 45))
        nameLabel.configureHeight(height: 25)
        
        nameTextField.configureConstraints(top: (nameLabel.bottomAnchor, 10))
        nameTextField.configureHeight(height: 55)
    }
}

// MARK: - Register View Protocol
extension RegisterViewController: RegisterPresenterOutput {
    
    func displayLoadingIndicator() {
        showLoadingView()
    }
    
    func dismissLoadingIndicator() {
        dismissLoadingView()
    }
    
    func showError(error: Error) {
        showErrorAlert(with: "Register Error", message: error.localizedDescription, buttonTitle: "OK")
    }
}

// MARK: - Auth Apple Protocol
extension RegisterViewController: AuthAppleDelegate {
    func userDidTappedAuthWithApple() {}
}

// MARK: - Auth Google Protocol
extension RegisterViewController: AuthGoogleDelegate {
    func userDidTappedAuthWithGoogle() {
        registerPresenter.loginWithGoogle(presenterViewController: self)
    }
}
