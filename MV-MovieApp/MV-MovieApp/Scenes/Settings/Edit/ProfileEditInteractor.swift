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
    private var isImageUploaded = false
    
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
        delegate?.showCurrentUser(currentUser: currentUser)
    }
    
    func uploadPicture(selectedPicker:SelectPickerView,
                     image: Data)
    {
        storageService.uploadMedia(with: image,
                                   selectedPicker: selectedPicker) { [weak self] (progress) in
            guard let self = self else { return }
            self.delegate?.initializeProgress(progress: progress)
        } completion: { [weak self] (url) in
            guard let self = self,
                  let url  = url?.absoluteString else { return }
            switch selectedPicker {
            case .profilePic:
                self.currentUser.profilePic    = url
            case .backgroundPic:
                self.currentUser.backgroundPic = url
            }
            self.isImageUploaded = true
            self.delegate?.showUpdatedPicture(with: url, selectedPicker: selectedPicker)
        }
    }
    
    func updateUser(with fullName: String,
                    username: String) {
        let _fullName = fullName != currentUser.fullName ? fullName : nil
        let _username = username != currentUser.username ? username : nil
        
        if _fullName != nil || _username != nil || isImageUploaded
        {
            do {
                try Validation.validate(username: _username)
                fireStoreService.isUsernameAlreadyExist(username: _username) { [weak self] isUsernameExist in
                    guard let self = self else { return }
                    
                    if isUsernameExist {
                        self.delegate?.showError(error: ValidationError.alreadyExistUsername(username: _username!))
                    } else {
                        self.delegate?.displayLoading()
                        
                        self.fireStoreService.updateUser(
                            with: _fullName,
                            username: _username,
                            profilePic: self.currentUser.profilePic,
                            backgroundPic: self.currentUser.backgroundPic) { [weak self] result in
                                guard let self = self else { return }
                                self.delegate?.dismissLoading()
                                
                                switch result {
                                case .success(let user):
                                    self.currentUser      = user
                                    self.isImageUploaded = false
                                    self.delegate?.showCurrentUser(currentUser: self.currentUser)
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
