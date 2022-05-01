//
//  SignUpAppleViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit

protocol SignUpAppleProtocol: AnyObject {
    func userDidTappedSignUpWithApple()
}

final class SignUpAppleViewController: SignUpContainerViewController {
    
    weak var delegate: SignUpAppleProtocol?
    
    init(delegate: SignUpAppleProtocol) {
        super.init(nibName: nil, bundle: nil)

        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func signUpWithSelectedContainer() {
        delegate?.userDidTappedSignUpWithApple()
    }
}

// MARK: - Configure
extension SignUpAppleViewController {
    
    private func configure() {
        setButton(with: .apple)
    }
}
