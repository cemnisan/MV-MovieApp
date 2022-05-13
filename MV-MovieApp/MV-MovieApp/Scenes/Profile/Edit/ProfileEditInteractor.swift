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
    private var isImageUploading = false
    
    init(currentUser: UserPresentation,
         storageService: UploadMediaService,
         fireStoreService: GoogleFireStoreService) {
        self.currentUser      = currentUser
        self.storageService   = storageService
        self.fireStoreService = fireStoreService
    }
}

extension ProfileEditInteractor: ProfileEditInteractorProtocol {
    
    func loadCurrentUser() {
        delegate?.showUpdatedUser(currentUser: currentUser)
    }
    
    func uploadImage(image: Data) {
        storageService.uploadMedia(with: image) { [weak self] progress in
            guard let self = self else { return }
            self.delegate?.initializeProgress(progress: progress)
        } completion: { [weak self] url in
            guard let self = self,
                  let url  = url?.absoluteString else { return }
            self.isImageUploading = true
            self.delegate?.showUpdatedImage(with: url)
        }
    }
    
    func updateUser(with fullName: String,
                    username: String) {
        let _fullName = fullName != currentUser.fullName ? fullName : nil
        let _username = username != currentUser.username ? username : nil
        
        if  _fullName != nil ||
            _username != nil ||
            isImageUploading
        {
            do {
                try Validation.validate(username: _username)
                fireStoreService.isUsernameAlreadyExist(username: _username) { [weak self] isUsernameExist in
                    guard let self = self else { return }
                    
                    if isUsernameExist {
                        self.delegate?.showError(error: ValidationError.alreadyExistUsername(username: _username!))
                    } else {
                        self.delegate?.displayLoading()
                        
                        self.fireStoreService.updateUser(with: _fullName,
                                                         username: _username,
                                                         profilePic: self.currentUser.profilePic) { [weak self] result in
                            guard let self = self else { return }
                            self.delegate?.dismissLoading()
                            
                            switch result {
                            case .success(let user):
                                self.currentUser      = user
                                self.isImageUploading = false
                                self.delegate?.showUpdatedUser(currentUser: self.currentUser)
                            case .failure(let error):
                                self.delegate?.showError(error: error)
                            }
                        }
                    }
                }
            } catch {
                delegate?.showError(error: error)
            }
        }
    }
}
