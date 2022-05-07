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
    weak var delegate: LoginInteractorDelegate?
    var user: UserPresentation!
    
    init(service: LoginService) {
        self.service = service
    }
}

// MARK: - Google Services Interactor
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
        do {
            try validate(email: email, password: password)
            
            service.login(with: email, password: password) { (result) in
                switch result {
                case .success(let user):
                    print(user)
                    self.delegate?.handleOutput(.showHomePage(user))
                case .failure(let error):
                    self.delegate?.handleOutput(.setError(error))
                }
            }
        } catch {
            self.delegate?.handleOutput(.setError(error))
        }
    }
}

// MARK: - Validation
extension LoginInteractor {
    
    private func validate(email: String,
                          password: String) throws {
        guard !email.isEmpty else { throw ValidationError.emptyEmail }
        guard K.Auth.emailRegex.matches(email) else { throw ValidationError.invalidEmail}
        
        guard !password.isEmpty else { throw ValidationError.emptyPassword }
        guard K.Auth.passwordRegex.matches(password) else { throw ValidationError.invalidPassword }
    }
}
