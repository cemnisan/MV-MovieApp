//
//  RegisterInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import Foundation

final class RegisterInteractor: BaseAuthenticateInteractor {
    
    var registerService: RegisterService
    var user: UserPresentation!
    
    init(registerService: RegisterService) {
        self.registerService = registerService
        
        super.init(service: registerService)
    }
}

// MARK: - Interactor Protocol
extension RegisterInteractor: RegisterInteractorProtocol {
    
    func register(with username: String,
                  email: String,
                  password: String) {
        do {
            try Validation.validate(username: username,
                                    email: email,
                                    password: password)
            delegate?.displayLoadingIndicator()
            
            registerService.register(with: username,
                                     email: email,
                                     password: password) { [weak self] in
                guard let self = self else { return }
                self.delegate?.dismissLoadingIndicator()
                self.delegate?.showHome()
            } failure: { [weak self] error in
                guard let self = self else { return }
                self.delegate?.dismissLoadingIndicator()
                self.delegate?.showHome()
            }
        } catch {
            delegate?.showError(error: error)
        }
    }
}
