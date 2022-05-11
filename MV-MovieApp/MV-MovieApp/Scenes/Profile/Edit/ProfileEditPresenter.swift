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
    func updateUser(with image: Data, fullName: String, username: String) {
        interactor.updateUser(with: image, fullName: fullName, username: username)
    }
    
    func uploadImage(image: Data) {
        interactor.uploadImage(image: image)
    }
    
    func loadCurrentUser() {
        interactor.loadCurrentUser()
    }
}

extension ProfileEditPresenter: ProfileEditInteractorOutput {
    
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
