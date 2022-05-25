//
//  RegisterInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import Foundation

final class RegisterInteractor: BaseAuthenticateInteractor {
    
    private let fireStoreService: GoogleFireStoreService
    private let registerService: RegisterService
    
    init(registerService: RegisterService,
         fireStoreService: GoogleFireStoreService) {
        self.registerService    = registerService
        self.fireStoreService   = fireStoreService
        
        super.init(authService: registerService, fireStoreService: fireStoreService)
    }
}

// MARK: - Interactor Protocol
extension RegisterInteractor: RegisterInteractorProtocol {
    
    func register(with username: String,
                  email: String,
                  password: String) {
        do {
            try Validation.validate(
                username: username,
                email: email,
                password: password)
            delegate?.displayLoadingIndicator()
            
            registerService.register(with: username,
                                     email: email,
                                     password: password) { [weak self] result in
                guard let self = self else { return }
                self.delegate?.dismissLoadingIndicator()
                
                switch result {
                case .success(let user):
                    self.fireStoreService.createUser(user: user)
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
