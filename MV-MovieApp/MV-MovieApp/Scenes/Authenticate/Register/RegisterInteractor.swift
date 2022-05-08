//
//  RegisterInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import Foundation
import UIKit.UIViewController

final class RegisterInteractor {
    
    var service: RegisterService
    weak var delegate: RegisterInteractorOutput?
    var user: UserPresentation!
    
    init(service: RegisterService) {
        self.service = service
    }
}

// MARK: - Interactor Protocol
extension RegisterInteractor: RegisterInteractorProtocol {
    func loginWithGoogle(presenterController presenter: UIViewController) {
        delegate?.displayLoadingIndicator()
        
        service.login(presenterViewController: presenter) { [weak self] (result) in
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
    }
    
    func register(with username: String,
                  email: String,
                  password: String) {
        do {
            try Validation.validate(username: username,
                                    email: email,
                                    password: password)
            delegate?.displayLoadingIndicator()
            
            service.register(with: username,
                             email: email,
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
