//
//  ProfileEditInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 11.05.2022.
//

import Foundation

final class ProfileEditInteractor {
    
    weak var delegate: ProfileEditInteractorOutput?
    private(set) var currentUser: UserPresentation!
    
    init(currentUser: UserPresentation) {
        self.currentUser = currentUser
    }
}

extension ProfileEditInteractor: ProfileEditInteractorProtocol {
    
    func loadCurrentUser() {
        delegate?.showCurrentUser(currentUser: currentUser)
    }
}
