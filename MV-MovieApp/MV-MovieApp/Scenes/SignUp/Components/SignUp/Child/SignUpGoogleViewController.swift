//
//  SignUpGoogleViewControlelr.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation

protocol SignUpGoogleDelegate: AnyObject {
    func userDidTappedSignUpWithGoogle()
}

final class SignUpGoogleViewController: SignUpContainerViewController {
    
    weak var delegate: SignUpGoogleDelegate?
    
    init(delegate: SignUpGoogleDelegate) {
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
        delegate?.userDidTappedSignUpWithGoogle()
    }
}

// MARK: - Configure
extension SignUpGoogleViewController {
    
    private func configure() {
        setButton(with: .google)
    }
}
