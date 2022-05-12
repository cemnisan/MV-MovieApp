//
//  ProfileEditInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 11.05.2022.
//

import Foundation

final class ProfileEditInteractor {
    
    private let storageService: UploadMediaService
    private let fireStoreService: GoogleFireStoreService
    weak var delegate: ProfileEditInteractorOutput?
    
    private(set) var currentUser: UserPresentation!
    
    init(currentUser: UserPresentation,
         storageService: UploadMediaService,
         fireStoreService: GoogleFireStoreService) {
        self.currentUser    = currentUser
        self.storageService = storageService
        self.fireStoreService = fireStoreService
    }
}

extension ProfileEditInteractor: ProfileEditInteractorProtocol {

    func loadCurrentUser() {
        delegate?.showCurrentUser(currentUser: currentUser)
    }
    
    func uploadImage(image: Data) {
        storageService.uploadMedia(with: image) { [weak self] progress in
            guard let self = self else { return }
            self.delegate?.initializeProgress(progress: progress)
        } completion: { [weak self] url in
            guard let self = self,
                  let url  = url?.absoluteString else { return }
            self.delegate?.showUpdatedImage(with: url)
        }
    }

    func updateUser(with fullName: String,
                    username: String,
                    email: String) {
        let user = UserPresentation(fullName: fullName,
                                    username: username,
                                    email: email,
                                    imageURL: currentUser.imageURL,
                                    id: currentUser.id)
        self.delegate?.displayLoading()
        
        fireStoreService.updateUser(user: user) { [weak self] result in
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
}
