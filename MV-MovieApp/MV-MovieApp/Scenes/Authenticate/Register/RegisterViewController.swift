//
//  RegisterViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit
import MV_Components

final class RegisterViewController: BaseAuthViewController {
    
    private let usernameForm = MVForm(
        frame: .zero,
        label: "Username",
        placeHolder: "Select a Username",
        height: 55)
    
    var registerPresenter: RegisterPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setUIElements(for: .register)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func addChildElements() {
        let registerWithAppleViewController  = AuthAppleViewController(delegate: self)
        let registerWithGoogleViewController = AuthGoogleViewController(delegate: self)
        
        add(childVC: registerWithAppleViewController, to: appleView)
        add(childVC: registerWithGoogleViewController, to: googleView)
    }
    
    override func configureFormElemnts() {
        [usernameForm,
         emailForm,
         passwordForm
        ].forEach { formStackView.addArrangedSubview($0) }
        view.addSubview(formStackView)
        
        formStackView.configureConstraints(
            top: (appleView.bottomAnchor, 45),
            leading: (view.leadingAnchor, 22),
            trailing: (view.trailingAnchor, -22))
        formStackView.configureHeight(height: 270)
    }
    
    override func userDidTappedActionButton() {
        registerPresenter.register(
            username: usernameForm.formTextField.text!,
            email: emailForm.formTextField.text!,
            password: passwordForm.formTextField.text!)
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
        configureFormElemnts()
        configurePasswordVisibilty()
        configureActionButton()
        layoutAccount()
    }
}

// MARK: - Register Presenter Output
extension RegisterViewController: RegisterPresenterOutput {
    
    func displayLoadingIndicator() {
        showLoadingView()
    }
    
    func dismissLoadingIndicator() {
        dismissLoadingView()
    }
    
    func showError(error: Error) {
        showAlert(
            type: .info,
            title: "Register Error",
            message: error.localizedDescription,
            buttonTitle: "OK")
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
