//
//  ProfileEditInteractor.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 11.05.2022.
//

import Foundation

final class ProfileEditInteractor {
    
    private let storageService: UploadMediaService
    weak var delegate: ProfileEditInteractorOutput?
    private(set) var currentUser: UserPresentation!
    
    init(currentUser: UserPresentation,
         storageService: UploadMediaService) {
        self.currentUser    = currentUser
        self.storageService = storageService
    }
}

extension ProfileEditInteractor: ProfileEditInteractorProtocol {
    
    func uploadImage(image: Data) {
        delegate?.displayLoading()
        print("diplaay")
        storageService.uploadMedia(with: image) { url in
            guard let url = url else { return }
            self.delegate?.dismissLoading()
            self.delegate?.showUpdatedImage(with: url)
            print("dismiss")
        }
    }

    func loadCurrentUser() {
        delegate?.showCurrentUser(currentUser: currentUser)
    }
    
    func updateUser(with image: Data,
                    fullName: String,
                    username: String) {
        delegate?.displayLoading()
       
        delegate?.dismissLoading()
    }
}
