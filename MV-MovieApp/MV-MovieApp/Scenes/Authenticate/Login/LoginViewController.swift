//
//  LoginUpViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit
import MV_Components
import AuthenticationServices

final class LoginViewController: BaseAuthViewController {
    
    var loginPresenter: LoginPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        createDismissKeyboardTapGesture()
        setUIElements(for: .login)
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
        let loginWithAppleViewController  = AuthAppleViewController(delegate: self)
        let loginWithGoogleViewController = AuthGoogleViewController(delegate: self)
        
        add(childVC: loginWithAppleViewController,  to: appleView)
        add(childVC: loginWithGoogleViewController, to: googleView)
    }
    
    override func configureFormElements() {
        [emailForm, passwordForm].forEach { formStackView.addArrangedSubview($0) }
        view.addSubview(formStackView)
        
        formStackView.configureConstraints(
            top: (appleView.bottomAnchor, 45),
            leading: (view.leadingAnchor, 22),
            trailing: (view.trailingAnchor, -22))
        formStackView.configureHeight(height: 170)
    }
        
    override func userDidTappedActionButton() {
        guard let email    = emailForm.formTextField.text,
              let password = passwordForm.formTextField.text else { return }
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
        configureFormElements()
        configurePasswordVisibilty()
        configureActionButton()
        layoutAccount()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        loginPresenter.loginWithCredential(credential: credential)
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}

// MARK: - Login With Apple
extension LoginViewController: AuthAppleDelegate {
    
    func userDidTappedAuthWithApple() {
        loginPresenter.loginWithApple(presenterViewController: self, selectedAuthController: .login)
    }
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
        showAlert(
            type: .info,
            title: "Login Error",
            message: error.localizedDescription,
            buttonTitle: "OK")
    }
}
