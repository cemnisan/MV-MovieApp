//
//  BaseAuthenticateInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 9.05.2022.
//

import UIKit
import AuthenticationServices

class BaseAuthenticateInteractor {
    
    private let authService: BaseAuthenticateService
    private let fireStoreService: GoogleFireStoreService
    
    weak var delegate: BaseAuthenticateInteractorOutput?
    
    init(authService: BaseAuthenticateService,
         fireStoreService: GoogleFireStoreService) {
        self.authService      = authService
        self.fireStoreService = fireStoreService
    }
}

extension BaseAuthenticateInteractor: BaseAuthenticateInteractorProtocol {
    
    func loginWithGoogle(presenterController presenter: UIViewController) {
        delegate?.displayLoadingIndicator()
        
        authService.login(withGooglePresenter: presenter) { [weak self] (result) in
            guard let self = self else { return }
            self.delegate?.dismissLoadingIndicator()
            
            switch result {
            case .success(let user):
                self.fireStoreService.isUserAlreadyExist(registeredUser: user) { isExist in
                    if !isExist {
                        self.fireStoreService.createUser(user: user)
                    }
                }
                AppData.enableAutoLogin = true
                self.delegate?.showHome()
            case .failure(let error):
                self.delegate?.showError(error: error)
            }
        }
    }
    
    func loginWithApple(presenterController presenter: BaseAuthViewController, selectedAuthController: SelectAuthController) {
        authService.login(withApplePresenter: presenter, selectedAuthController: selectedAuthController)
    }
    
    func loginWithCredential(credential: ASAuthorizationAppleIDCredential) {
        delegate?.displayLoadingIndicator()
        authService.loginWithAppleCredential(credential: credential) { [weak self] (result) in
            guard let self = self else { return }
            self.delegate?.dismissLoadingIndicator()
            
            switch result {
            case .success(let user):
                self.fireStoreService.isUserAlreadyExist(registeredUser: user) { isExist in
                    if !isExist { self.fireStoreService.createUser(user: user) }
                }
                AppData.enableAutoLogin = true
                self.delegate?.showHome()
            case .failure(let error):
                print(error)
                self.delegate?.showError(error: error)
            }
        }
    }
}
