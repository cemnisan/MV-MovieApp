//
//  ProfileContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 10.05.2022.
//

import Foundation

protocol ProfileInteractorProtocol: AnyObject {
    var delegate: ProfileInteractorOutput? { get set }
    
    func tappedLogoutButton()
}

protocol ProfileInteractorOutput: AnyObject {
    func showLogin()
}

protocol ProfilePresenterProtocol: AnyObject {
    func tappedLogoutButton()
    func tappedEditButton()
    
    func selectSetting(at section: Int, index: Int)
}

protocol ProfilePresenterOutput: AnyObject {
}

protocol ProfileRoute: AnyObject {
    func toLogin()
    func toEdit()
    func toSelectedSetting(_ setting: SettingsOption)
}
