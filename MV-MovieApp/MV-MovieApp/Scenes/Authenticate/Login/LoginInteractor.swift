//
//  LoginInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation

final class LoginInteractor: BaseAuthenticateInteractor {
    
    var loginService: LoginService
    var user: UserPresentation!
    
    init(loginService: LoginService) {
        self.loginService = loginService
        
        super.init(service: loginService)
    }
}

// MARK: - Google Services Interactor
extension LoginInteractor: LoginInteractorProtocol {
    
    func login(with email: String, password: String) {
        do {
            try Validation.validate(email: email, password: password)
            delegate?.displayLoadingIndicator()
            
            loginService.login(with: email,
                           password: password) { [weak self] (result) in
                guard let self = self else { return }
                self.delegate?.dismissLoadingIndicator()
                
                switch result {
                case .success(let user):
                    print(user)
                    self.delegate?.showHome()
                case .failure(let error):
                    self.delegate?.showError(error: error)
                }
            }
        } catch {
            delegate?.showError(error: error)
        }
    }
}
