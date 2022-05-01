//
//  SignUpContainerViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit
import MV_Components

class AuthenticateContainerViewController: UIViewController {
    
    let signUpButton = MVButton(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

// MARK: - Configure
extension AuthenticateContainerViewController {
    
    private func configure() {
        view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            signUpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 24),
            signUpButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}

// MARK: - Button Tapped
extension AuthenticateContainerViewController {
    
    @objc
    func authWithSelectedContainer() { }
}

// MARK: - Type Selector
extension AuthenticateContainerViewController {
    
    func setButton(with type: SignUpButtonTypes) {
        switch type {
        case .apple:
            signUpButton.setImage(UIImage(named: "apple"), for: .normal)
            signUpButton.addTarget(self,
                                   action: #selector(authWithSelectedContainer),
                                   for: .touchUpInside)
        case .google:
            signUpButton.setImage(UIImage(named: "google"), for: .normal)
            signUpButton.addTarget(self,
                                   action: #selector(authWithSelectedContainer),
                                   for: .touchUpInside)
        }
    }

}