//
//  ProfilePresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 13.05.2022.
//

import Foundation

final class ProfilePresenter {
    
    private unowned var view: ProfilePresenterOutput
    private let interactor: ProfileInteractorProtocol
    private let router: ProfileRouter
    
    init(view: ProfilePresenterOutput,
         interactor: ProfileInteractorProtocol,
         router: ProfileRouter) {
        self.view       = view
        self.interactor = interactor
        self.router     = router
        
        interactor.delegate = self
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    
    func loadCurrentUser() {
        interactor.loadCurrentUser()
    }
    
    func editProfileTapped() {
        router.toEditProfile()
    }
}

extension ProfilePresenter: ProfileInteractorOutput {
    
    func showCurrentUser(currentUser: UserPresentation) {
        view.showCurrentUser(currentUser: currentUser)
    }
}
