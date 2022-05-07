//
//  LoginInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation
import UIKit.UIViewController

final class LoginInteractor: LoginInteractorProtocol {
    
    var service: AuthenticationService
    var delegate: LoginInteractorDelegate?
    var user: UserPresentation!
    
    init(service: AuthenticationService) {
        self.service = service
    }
}

extension LoginInteractor {
    
    func loginWithGoogle(presenterViewController presenter: UIViewController) {
        service.loginWithGoogle(presenterViewController: presenter) { (result) in
            
            switch result {
            case .success(let user):
                self.delegate?.handleOutput(.showHomePage(user))
            case .failure(let error):
                self.delegate?.handleOutput(.setError(error))
            }
        }
    }
}
