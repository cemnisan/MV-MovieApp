//
//  RegisterViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit
import MV_Components

final class RegisterViewController: BaseAuthViewController {
    
    private let nameLabel     = MVSecondaryLabel(textAlignment: .left, fontSize: 21, textColor: K.Auth.labelTextColor, text: K.Auth.nameLabel)
    private let nameTextField = MVSignUpTextFields(placeHolder: K.Auth.nameTextField)
  
    var registerPresenter: RegisterPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setUIElements(on: .register)
    }
    
    override func addChildElements() {
        let registerWithAppleViewController  = AuthAppleViewController(delegate: self)
        let registerWithGoogleViewController = AuthGoogleViewController(delegate: self)
        
        add(childVC: registerWithAppleViewController, to: appleView)
        add(childVC: registerWithGoogleViewController, to: googleView)
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
            emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            emailLabel.heightAnchor.constraint(equalToConstant: 25),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            emailTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    override func userTappedActionButton() {
        print("user did tapped create action button.")
    }
    
    override func userTappedAccountActionButton() {
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
}

// MARK: - Sign Up View Protocol
extension RegisterViewController: RegisterViewProtocol {}

// MARK: - Sign Up With Apple - Protocol
extension RegisterViewController: AuthAppleDelegate {
    func userDidAuthWithApple() {}
}

// MARK: - Sign Up With Google - Protocol
extension RegisterViewController: AuthGoogleDelegate {
    func userDidAuthWithGoogle() {}
}
