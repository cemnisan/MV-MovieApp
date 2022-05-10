//
//  ProfileContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 10.05.2022.
//

import Foundation

protocol ProfileInteractorProtocol: AnyObject {}
protocol ProfileInteractorOutput: AnyObject {}

protocol ProfilePresenterProtocol: AnyObject {
    func selectEditButton()
    func selectSetting(at section: Int, index: Int)
}

protocol ProfilePresenterOutput: AnyObject {
}

protocol ProfileRoute: AnyObject {
    func toEdit()
    func toSelectedSetting(at setting: SettingsOption)
}
