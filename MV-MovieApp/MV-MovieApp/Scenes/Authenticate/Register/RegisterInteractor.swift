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
    weak var delegate: RegisterInteractorDelegate?
    var user: UserPresentation!
    
    init(service: RegisterService) {
        self.service = service
    }
}

// MARK: - Interactor Protocol
extension RegisterInteractor: RegisterInteractorProtocol {
    func loginWithGoogle(presenterViewController presenter: UIViewController) {
        service.login(presenterViewController: presenter) { (result) in
            switch result {
            case .success(let user):
                print(user)
                self.delegate?.handleOutput(.showHomePage)
            case .failure(let error):
                self.delegate?.handleOutput(.setError(error))
            }
        }
    }
    
    func register(with username: String,
                  email: String,
                  password: String) {
        service.register(with: username,
                         email: email,
                         password: password) { (result) in
            switch result {
            case .success(let user):
                print(user)
                self.delegate?.handleOutput(.showHomePage)
            case .failure(let error):
                print(error)
            }
        }
    }
}
