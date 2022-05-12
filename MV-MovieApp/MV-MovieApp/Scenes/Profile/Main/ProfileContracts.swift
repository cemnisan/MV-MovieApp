//
//  ProfileContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 10.05.2022.
//

import Foundation

protocol ProfileInteractorProtocol: AnyObject {
    var delegate: ProfileInteractorOutput? { get set }
    
    func loadCurrentUser()
    
    func editButtonTapped()
    func logoutButtonTapped()
}

protocol ProfileInteractorOutput: AnyObject {
    func showCurrentUser(currentUser: UserPresentation)
    func showEditableUser(currentUser: UserPresentation)
    func showLogin()
    func showError(error: Error)
}

protocol ProfilePresenterProtocol: AnyObject {
    func loadCurrentUser()
    
    func editButtonTapped()
    func logoutTapped()
    func selectSetting(at section: Int, index: Int)
}

protocol ProfilePresenterOutput: AnyObject {
    func showCurrentUser(currentUser: UserPresentation)
    func showError(error: Error)
}

protocol ProfileRoute: AnyObject {
    func toLogin()
    func toEdit(with currentUser: UserPresentation)
    func toSelectedSetting(_ setting: SettingsOption)
}
