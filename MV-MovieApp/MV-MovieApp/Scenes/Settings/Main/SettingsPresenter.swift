//
//  SettingsPresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 10.05.2022.
//

import Foundation

final class SettingsPresenter {
    
    private let interactor: SettingsInteractorProtocol
    private let router: SettingsRoute
    private unowned let view: SettingsPresenterOutput
    
    init(interactor: SettingsInteractorProtocol,
         router: SettingsRoute,
         view: SettingsPresenterOutput) {
        self.interactor     = interactor
        self.router         = router
        self.view           = view
        
        interactor.delegate = self
    }
}

// MARK: - Presenter Protocol
extension SettingsPresenter: SettingsPresenterProtocol {
    
    func editButtonTapped() {
        interactor.editButtonTapped()
    }
    
    func loadCurrentUser() {
        interactor.loadCurrentUser()
    }

    func logoutTapped() {
        interactor.logoutButtonTapped()
    }
    
    func selectSetting(at section: Int, index: Int) {
        let setting = Section.settings[section].option[index]
        router.toSelectedSetting(setting)
    }
}

// MARK: - Interactor Output
extension SettingsPresenter: SettingsInteractorOutput {
   
    func displayLoading() {
        view.displayLoading()
    }
    
    func dismissLoading() {
        view.dismissLoading()
    }
    
    func showEditableUser(currentUser: UserPresentation) {
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
