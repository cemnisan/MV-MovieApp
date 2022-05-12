//
//  ProfileEditPresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 11.05.2022.
//

import Foundation

final class ProfileEditPresenter {
    
    private let interactor: ProfileEditInteractorProtocol
    private unowned let view: ProfileEditPresenterOutput
    
    init(interactor: ProfileEditInteractorProtocol,
         view: ProfileEditPresenterOutput) {
        self.interactor = interactor
        self.view       = view
        
        interactor.delegate = self
    }
}

extension ProfileEditPresenter: ProfileEditPresenterProtocol {
    func getCurrentProfilePicture() {
        interactor.getCurrentProfilePicture()
    }
    
    func uploadImage(image: Data) {
        interactor.uploadImage(image: image)
    }
    
    func updateUser(with fullName: String,
                    username: String,
                    email: String) {
        interactor.updateUser(with: fullName,
                              username: username,
                              email: email)
    }
    
    func loadCurrentUser() {
        interactor.loadCurrentUser()
    }
}

extension ProfileEditPresenter: ProfileEditInteractorOutput {
    
    func currentProfilePicture(imageURL: String) {
        view.currentProfilePicture(imageURL: imageURL)
    }

    func showUpdatedImage(with url: URL) {
        view.showUpdatedImage(with: url)
    }
    
    func displayLoading() {
        view.displayLoading()
    }
    
    func dismissLoading() {
        view.dismissLoading()
    }
    
    func showCurrentUser(currentUser: UserPresentation) {
        view.showCurrentUser(currentUser: currentUser)
    }
}
