//
//  BaseAuthenticateInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 9.05.2022.
//

import UIKit
import enum MovieDB_Wrapper.Result
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
            self.loginResults(result: result)
        }
    }
    
    func getAppleCredential(presenterController presenter: BaseAuthViewController,
                            selectedAuthController: SelectAuthController) {
        authService.getAppleCredential(withApplePresenter: presenter,
                          selectedAuthController: selectedAuthController)
    }
    
    func loginWithAppleCredential(credential: ASAuthorizationAppleIDCredential) {
        delegate?.displayLoadingIndicator()
        
        authService.loginWithAppleCredential(credential: credential) { [weak self] (result) in
            guard let self = self else { return }
            self.delegate?.dismissLoadingIndicator()
            self.loginResults(result: result)
        }
    }
}

// MARK: - Login Results
extension BaseAuthenticateInteractor {
    private func loginResults(result: Result<UserPresentation>) {
        switch result {
        case .success(let user):
            fireStoreService.saveLoggedInUserIfNeeded(loggedInUser: user)
            AppData.enableAutoLogin = true
            delegate?.showHome()
        case .failure(let error):
            print(error)
            delegate?.showError(error: error)
        }
    }
}
