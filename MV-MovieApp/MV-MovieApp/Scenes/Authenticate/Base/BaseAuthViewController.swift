//
//  AuthBaseViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import UIKit
import MV_Components

class BaseAuthViewController: BaseViewController {
    
    let viewTitle = MVSecondaryLabel(
        textAlignment: .left,
        fontSize: 16,
        textColor: K.Styles.globalColor,
        text: nil)
    
    let appleView  = MVContainerView(backgroundColor: K.Styles.childViewsColor)
    let googleView = MVContainerView(backgroundColor: K.Styles.childViewsColor)
    
    let emailForm = MVForm(
        frame: .zero,
        label: "Email",
        placeHolder: "Select a Email",
        height: 55)
    let passwordForm = MVForm(
        frame: .zero,
        label: "Password",
        placeHolder: "Select a Password",
        height: 55)
    
    let formStackView = MVFormStackView(stackSpacing: 30)
    let passwordVisibilityButton = MVButton(frame: .zero)
    
    let actionButton = MVButton(
        backgroundColor: K.Styles.actionButtonColor,
        title: nil,
        cornerRadius: 10)
    let accountLabel = MVSecondaryLabel(
        textAlignment: .center,
        fontSize: 20,
        textColor: K.Styles.globalColor,
        text: nil)
    
    let accountActionButton = MVButton(frame: .zero)
}

// MARK: - Add Elements
extension BaseAuthViewController {
    
    func addElements() {
        view.addSubviews(
            views: viewTitle,
            appleView,
            googleView,
            passwordVisibilityButton,
            actionButton)
    }
}

// MARK: - Configure
extension BaseAuthViewController {
    
    // MARK: - Configure ViewController
    func configureViewController(on controller: SelectAuthController) {
        view.backgroundColor                                             = K.Styles.backgroundColor
        navigationController?.navigationBar.prefersLargeTitles           = true
        
        switch controller {
        case .login:
            title                                                        = K.Auth.loginNavTitle
            navigationController?.navigationBar.largeTitleTextAttributes = K.Styles.navTitleColor
        case .register:
            title                                                        = K.Auth.registerNavTitle
            navigationController?.navigationBar.largeTitleTextAttributes = K.Styles.navTitleColor
            navigationController?.navigationBar.tintColor                = K.Styles.labelTextColor
        }
    }
    
    // MARK: - Configure Screen Desc.
    func configureScreenDescriptionLabel() {
        viewTitle.configureConstraints(
            top: (view.safeAreaLayoutGuide.topAnchor, 32),
            leading: (view.leadingAnchor, 22),
            trailing: (view.trailingAnchor, -22))
        viewTitle.configureHeight(height: 20)
    }
    
    // MARK: - Configure Apple/Google View
    func configureChildViews() {
        [appleView,
         googleView
        ].forEach {
            $0.configureHeight(height: 60)
            $0.configureWidth(width: 160)
        }
        layoutChildViews()
        addChildElements()
    }
    
    func layoutChildViews() {
        let stackView          = UIStackView(arrangedSubviews: [appleView, googleView])
        stackView.axis         = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        stackView.configureConstraints(
            top: (viewTitle.bottomAnchor, 42),
            leading: (view.leadingAnchor, 22),
            trailing: (view.trailingAnchor, -22))
        stackView.configureHeight(height: 60)
    }
    
    // MARK: - Configure Password Visibility
    func configurePasswordVisibilty() {
        passwordVisibilityButton.tintColor = K.Styles.globalColor
        passwordVisibilityButton.setImage(K.Auth.passwordInvisible, for: .normal)
        passwordVisibilityButton.addTarget(
            self,
            action: #selector(changePasswordVisibility),
            for: .touchUpInside)
        passwordVisibilityButton.configureConstraints(
            trailing: (passwordForm.formTextField.trailingAnchor, -8),
            centerY: (passwordForm.formTextField.centerYAnchor, 0))
        view.bringSubviewToFront(passwordVisibilityButton)
        passwordVisibilityButton.configureWidth(width: 30)
        passwordVisibilityButton.configureHeight(height: 30)
    }
    
    // MARK: - Configure Login or Register Button
    func configureActionButton() {
        actionButton.addTarget(
            self,
            action: #selector(userDidTappedActionButton),
            for: .touchUpInside)
        actionButton.configureConstraints(
            top: (passwordForm.formTextField.bottomAnchor, 53),
            leading: (view.leadingAnchor, 22),
            trailing: (view.trailingAnchor, -22))
        actionButton.configureHeight(height: 55)
    }
    
    // MARK: - Layout Already or don't account.
    func layoutAccount() {
        let stackView            = UIStackView()
        stackView.axis           = .horizontal
        stackView.distribution   = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        accountActionButton.addTarget(
            self,
            action: #selector(userDidTappedAccountButton),
            for: .touchUpInside)
        [accountLabel,
         accountActionButton
        ].forEach { stackView.addArrangedSubview($0) }
        view.addSubview(stackView)
        
        stackView.configureConstraints(
            leading: (view.leadingAnchor, 53),
            trailing: (view.trailingAnchor, -68),
            bottom: (actionButton.bottomAnchor, 72))
        stackView.configureHeight(height: 30)
    }
}

// MARK: - Set UI
extension BaseAuthViewController {
    
    func setUIElements(for controller: SelectAuthController) {
        switch controller {
        case .login:
            viewTitle.text        = K.Auth.loginScreenTitle
            accountLabel.text     = K.Auth.loginAccountLabel
            actionButton.setTitle(K.Auth.loginActionButton, for: .normal)
            accountActionButton.setTitle(K.Auth.loginAccountActionButton, for: .normal)
        case .register:
            viewTitle.text        = K.Auth.registerScreenTitle
            accountLabel.text     = K.Auth.registerAccountLabel
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
        passwordForm.formTextField.isSecureTextEntry.toggle()
        
        switch passwordForm.formTextField.isSecureTextEntry {
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
    // Override it according to Login or Register screen
    func configureFormElements() {}
    
    @objc
    /// Override to show apple/google views on the screen and set their delegates.
    func addChildElements() {}
    
    @objc
    /// Override for Login or Register action
    func userDidTappedActionButton() {}
    
    @objc
    /// Override it if the user doesn't have an account / already an account
    func userDidTappedAccountButton() {}
}
