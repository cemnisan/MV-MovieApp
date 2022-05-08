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
    weak var delegate: LoginInteractorOutput?
    var user: UserPresentation!
    
    init(service: LoginService) {
        self.service = service
    }
}

// MARK: - Google Services Interactor
extension LoginInteractor {
    
    func loginWithGoogle(presenterViewController presenter: UIViewController) {
        delegate?.displayLoadingIndicator()
        
        service.login(presenterViewController: presenter) { [weak self] (result) in
            guard let self = self else { return }
            self.delegate?.dismissLoadingIndicator()
            
            switch result {
            case .success(_):
                self.delegate?.showHome()
            case .failure(let error):
                self.delegate?.showError(error: error)
            }
        }
    }
    
    func login(with email: String, password: String) {
        do {
            try Validation.validate(email: email, password: password)
            delegate?.displayLoadingIndicator()

            service.login(with: email,
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
