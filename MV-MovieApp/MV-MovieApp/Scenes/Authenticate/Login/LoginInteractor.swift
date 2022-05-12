//
//  LoginInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import Foundation

final class LoginInteractor: BaseAuthenticateInteractor {
    
    private let loginService: LoginService
    private let fireStoreService: GoogleFireStoreService
    
    init(loginService: LoginService,
         fireStoreService: GoogleFireStoreService) {
        self.loginService     = loginService
        self.fireStoreService = fireStoreService
    
        super.init(authService: loginService, fireStoreService: fireStoreService)
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
                case .success(_):
                    AppData.enableAutoLogin = true
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
