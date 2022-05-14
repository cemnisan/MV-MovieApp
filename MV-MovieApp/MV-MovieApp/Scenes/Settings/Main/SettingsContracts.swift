//
//  ProfileContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 10.05.2022.
//

import Foundation

protocol SettingsInteractorProtocol: AnyObject {
    var delegate: SettingsInteractorOutput? { get set }
    
    func loadCurrentUser()

    func editButtonTapped()
    func logoutButtonTapped()
}

protocol SettingsInteractorOutput: AnyObject {
    func showCurrentUser(currentUser: UserPresentation)
    func showEditableUser(currentUser: UserPresentation)
    func showLogin()
    func showError(error: Error)
}

protocol SettingsPresenterProtocol: AnyObject {
    func loadCurrentUser()

    func editButtonTapped()
    func logoutTapped()
    func selectSetting(at section: Int, index: Int)
}

protocol SettingsPresenterOutput: AnyObject {
    func showCurrentUser(currentUser: UserPresentation)
    func showError(error: Error)
}

protocol SettingsRoute: AnyObject {
    func toLogin()
    func toEdit(with currentUser: UserPresentation)
    func toSelectedSetting(_ setting: SettingOption)
}
