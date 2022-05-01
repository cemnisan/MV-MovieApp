//
//  SignUpContainerViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit
import MV_Components

class SignUpContainerViewController: UIViewController {
    
    let signUpApple       = MVLogoContainerView(frame: .zero)
    let signUpGoogle      = MVLogoContainerView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

// MARK: - Configure
extension SignUpContainerViewController {
    
    private func configure() {
        [signUpApple, signUpGoogle].forEach {
            view.addSubview($0)
            
            NSLayoutConstraint.activate([
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    }
}
