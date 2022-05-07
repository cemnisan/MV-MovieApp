//
//  LoginInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation
import UIKit.UIViewController

final class LoginInteractor: LoginInteractorProtocol {
    
    var service: LoginService
    var delegate: LoginInteractorDelegate?
    var user: UserPresentation!
    
    init(service: LoginService) {
        self.service = service
    }
}

extension LoginInteractor {
    
    func loginWithGoogle(presenterViewController presenter: UIViewController) {
        service.login(presenterViewController: presenter) { (result) in
            switch result {
            case .success(let user):
                self.delegate?.handleOutput(.showHomePage(user))
            case .failure(let error):
                self.delegate?.handleOutput(.setError(error))
            }
        }
    }
    
    func login(with email: String, password: String) {
        service.login(with: email,
                      password: password) { (result) in
            switch result {
            case .success(let user):
                print(user)
                self.delegate?.handleOutput(.showHomePage(user))
            case .failure(let error):
                self.delegate?.handleOutput(.setError(error))
            }
        }
    }
}
