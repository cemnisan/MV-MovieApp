//
//  SignUpAppleViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit

final class SignUpAppleViewController: SignUpContainerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

// MARK: - Configure
extension SignUpAppleViewController {
    
    private func configure() {
        signUpApple.set(type: .apple)
    }
}
