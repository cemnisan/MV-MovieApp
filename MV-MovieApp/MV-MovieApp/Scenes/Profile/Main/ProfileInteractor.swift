//
//  ProfileInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 10.05.2022.
//

import Foundation

final class ProfileInteractor {
    
    private let service: SignOutService
    var delegate: ProfileInteractorOutput?
    
    init(service: SignOutService) {
        self.service = service
    }
}

extension ProfileInteractor: ProfileInteractorProtocol {
    
    func tappedLogoutButton() {
        service.signOut { [weak self] error in
            guard let self = self else { return }
            guard error == nil else { return }
            
            self.delegate?.showLogin()
        }
    }
}
