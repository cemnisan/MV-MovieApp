//
//  ProfileInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 10.05.2022.
//

import Foundation

final class ProfileInteractor {
    
    private let userService: UserService
    var delegate: ProfileInteractorOutput?
    
    init(userService: UserService) {
        self.userService = userService
    }
}

extension ProfileInteractor: ProfileInteractorProtocol {
    
    func loadCurrentUser() {
        guard let user = userService.getCurrentUser() else { return }
        
        delegate?.showCurrentUser(currentUser: user)
    }

    func tappedLogoutButton() {
        userService.signOut { [weak self] in
            guard let self = self else { return }
            self.delegate?.showLogin()
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.delegate?.showError(error: error)
        }
    }
}
