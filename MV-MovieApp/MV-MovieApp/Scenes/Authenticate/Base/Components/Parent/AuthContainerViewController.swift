//
//  SignUpContainerViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit
import MV_Components

class AuthContainerViewController: UIViewController {
    
    private let actionButton = MVButton(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

// MARK: - Configure
extension AuthContainerViewController {
    
    private func configure() {
        view.addSubview(actionButton)
        
        actionButton.configureConstraints(centerX: (view.centerXAnchor, 0),
                                          centerY: (view.centerYAnchor, 0))
        actionButton.configureHeight(height: 24)
        actionButton.configureWidth(width: 24)
    }
}

// MARK: - Button Tapped
extension AuthContainerViewController {
    
    @objc
    func authWithSelectedContainer() { }
}

// MARK: - Type Selector
extension AuthContainerViewController {
    
    func setButton(with type: ButtonTypes) {
        switch type {
        case .apple:
            actionButton.setImage(K.Auth.appleViewImage, for: .normal)
            actionButton.addTarget(self,
                                   action: #selector(authWithSelectedContainer),
                                   for: .touchUpInside)
        case .google:
            actionButton.setImage(K.Auth.googleViewImage, for: .normal)
            actionButton.addTarget(self,
                                   action: #selector(authWithSelectedContainer),
                                   for: .touchUpInside)
        }
    }
}
