//
//  ProfileInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 13.05.2022.
//

import Foundation

final class ProfileInteractor {
    
    private let fireStoreService: GoogleFireStoreService
    var delegate: ProfileInteractorOutput?
    
    private(set) var currentUser: UserPresentation!
    
    init(fireStoreService: GoogleFireStoreService) {
        self.fireStoreService = fireStoreService
    }
}

extension ProfileInteractor: ProfileInteractorProtocol {
    
    func loadCurrentUser() {
        delegate?.displayLoading()
        
        fireStoreService.readUser { [weak self] (result) in
            guard let self = self else { return }
            self.delegate?.dismissLoading()
            
            switch result {
            case .success(let currentUser):
                self.currentUser = currentUser
                self.delegate?.showCurrentUser(currentUser: self.currentUser)
            case .failure(let error):
                print(error)
            }
        }
    }
}
