//
//  SignUpViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit
import MV_Components

final class SignUpViewController: BaseAuthViewController {
    
    private let nameLabel                 = MVSecondaryLabel(textAlignment: .left, fontSize: 21, textColor: .white, text: "Name")
    private let nameTextField             = MVSignUpTextFields(placeHolder: "Enter your name")
  
    var signUpPresenter: SignUpPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setUIElements(on: .signup)
    }
    
    override func addChildElements() {
        let loginUpWithAppleViewController  = AuthAppleViewController(delegate: self)
        let loginUpWithGoogleViewController = AuthGoogleViewController(delegate: self)
        
        add(childVC: loginUpWithAppleViewController, to: appleView)
        add(childVC: loginUpWithGoogleViewController, to: googleView)
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
extension SignUpViewController {
    
    // MARK: - All configuration
    private func configureUI() {
        configureViewController()
        configureScreenDescriptionLabel()
        configureChildViews()
        configureNameElements()
        configureEmailElements()
        configurePasswordElements()
        configurePasswordVisibilty()
        configureActionButton()
        layoutAccount()
    }
    
    // MARK: - Configure View Controller
    private func configureViewController() {
        view.backgroundColor = #colorLiteral(red: 0.1202597097, green: 0.1102947071, blue: 0.174954325, alpha: 1)
        title                = "Register"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
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
extension SignUpViewController: SignUpViewProtocol {}

// MARK: - Sign Up With Apple - Protocol
extension SignUpViewController: AuthAppleDelegate {
    func userDidAuthWithApple() {}
}

// MARK: - Sign Up With Google - Protocol
extension SignUpViewController: AuthGoogleDelegate {
    func userDidAuthWithGoogle() {}
}
