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
    
    private(set) var currentUser: UserPresentation!
    
    init(userService: UserService) {
        self.userService = userService
    }
}

extension ProfileInteractor: ProfileInteractorProtocol {

    func loadCurrentUser() {
        guard let user = userService.getCurrentUser() else { return }
        currentUser    = user
        delegate?.showCurrentUser(currentUser: currentUser)
    }

    func logoutTapped() {
        userService.signOut { [weak self] in
            guard let self = self else { return }
            AppData.enableAutoLogin = false
            self.delegate?.showLogin()
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.delegate?.showError(error: error)
        }
    }
    
    func editUserTapped() {
        delegate?.showEditUser(with: currentUser)
    }
}
