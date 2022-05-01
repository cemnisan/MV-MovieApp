//
//  SignUpGoogleViewControlelr.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation

final class SignUpGoogleViewController: SignUpContainerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

// MARK: - Configure
extension SignUpGoogleViewController {
    
    private func configure() {
        signUpApple.set(type: .google)
    }
}
