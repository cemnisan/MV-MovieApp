//
//  SignUpViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit
import MV_Components

final class SignUpViewController: UIViewController {
    
    private let signUpContent = MVSecondaryLabel(textAlignment: .left,
                                                 fontSize: 16,
                                                 textColor: #colorLiteral(red: 0.6117647059, green: 0.6117647059, blue: 0.6117647059, alpha: 1))
    private let stackView     = UIStackView()
    private let appleView     = UIView()
    private let googleView    = UIView()
    
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
    
    private func configureUIElements() {
        let signUpAppleViewController  = SignUpAppleViewController()
        let signUpGoogleViewController = SignUpGoogleViewController()
        
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

