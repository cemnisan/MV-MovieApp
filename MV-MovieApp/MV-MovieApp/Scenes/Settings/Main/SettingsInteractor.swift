//
//  SettingsInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 10.05.2022.
//

import Foundation

final class SettingsInteractor {
    
    private let userService: UserService
    private let fireStoreService: GoogleFireStoreService
    var delegate: SettingsInteractorOutput?
    
    private(set) var currentUser: UserPresentation!
    
    init(userService: UserService,
         fireStoreService: GoogleFireStoreService) {
        self.userService      = userService
        self.fireStoreService = fireStoreService
    }
}

extension SettingsInteractor: SettingsInteractorProtocol {

    func loadCurrentUser() {
        delegate?.displayLoading()
        
        fireStoreService.readUser { [weak self] (result) in
            guard let self = self else { return }
            self.delegate?.dismissLoading()
            
            switch result {
            case .success(let user):
                self.currentUser = user
                self.delegate?.showCurrentUser(currentUser: self.currentUser)
            case .failure(let error):
                self.delegate?.showError(error: error)
            }
        }
    }
    
    func logoutButtonTapped() {
        userService.signOut { [weak self] in
            guard let self = self else { return }
            AppData.enableAutoLogin = false
            self.delegate?.showLogin()
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.delegate?.showError(error: error)
        }
    }
    
    func editButtonTapped() {
        delegate?.showEditableUser(currentUser: currentUser)
    }
}
