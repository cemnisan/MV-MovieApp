//
//  ProfilePresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 10.05.2022.
//

import Foundation

final class ProfilePresenter {
    
    private let interactor: ProfileInteractorProtocol
    private let router: ProfileRoute
    private unowned let view: ProfilePresenterOutput
    
    init(interactor: ProfileInteractorProtocol,
         router: ProfileRoute,
         view: ProfilePresenterOutput) {
        self.interactor     = interactor
        self.router         = router
        self.view           = view
        
        interactor.delegate = self
    }
}

// MARK: - Presenter Protocol
extension ProfilePresenter: ProfilePresenterProtocol {
    
    func userEditTapped() {
        interactor.editUserTapped()
    }
    
    
    func loadCurrentUser() {
        interactor.loadCurrentUser()
    }

    func logoutTapped() {
        interactor.logoutTapped()
    }
    
    func selectSetting(at section: Int, index: Int) {
        let setting = Section.settings[section].option[index]
        router.toSelectedSetting(setting)
    }
}

// MARK: - Interactor Output
extension ProfilePresenter: ProfileInteractorOutput {
    
    func showEditUser(with currentUser: UserPresentation) {
        router.toEdit(with: currentUser)
    }
    
    func showError(error: Error) {
        view.showError(error: error)
    }
    
    func showCurrentUser(currentUser: UserPresentation) {
        view.showCurrentUser(currentUser: currentUser)
    }
    
    func showLogin() {
        router.toLogin()
    }
}
