//
//  SignUpGoogleViewControlelr.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation

protocol AuthGoogleDelegate: AnyObject {
    func userDidAuthWithGoogle()
}

final class AuthGoogleViewController: AuthContainerViewController {
    
    weak var delegate: AuthGoogleDelegate?
    
    init(delegate: AuthGoogleDelegate) {
        super.init(nibName: nil, bundle: nil)
        
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButton(with: .google)
    }
    
    override func authWithSelectedContainer() {
        delegate?.userDidAuthWithGoogle()
    }
}
