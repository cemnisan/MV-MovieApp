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
    func loadCurrentUser() {
        interactor.loadCurrentUser()
    }
}

extension ProfileEditPresenter: ProfileEditInteractorOutput {
    func showCurrentUser(currentUser: UserPresentation) {
        view.showCurrentUser(currentUser: currentUser)
    }
}
