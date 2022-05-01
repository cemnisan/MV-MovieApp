//
//  SignUpAppleViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation

protocol AuthAppleDelegate: AnyObject {
    func userDidAuthWithApple()
}

final class AuthAppleViewController: AuthenticateContainerViewController {
    
    weak var delegate: AuthAppleDelegate?
    
    init(delegate: AuthAppleDelegate) {
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
    
    override func authWithSelectedContainer() {
        delegate?.userDidAuthWithApple()
    }
}

// MARK: - Configure
extension AuthAppleViewController {
    
    private func configure() {
        setButton(with: .apple)
    }
}
