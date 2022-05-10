//
//  ProfilePresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 10.05.2022.
//

import Foundation

final class ProfilePresenter {
    
    private let router: ProfileRoute
    private let view: ProfilePresenterOutput
    
    init(router: ProfileRoute, view: ProfilePresenterOutput) {
        self.router = router
        self.view   = view
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    
    func selectEditButton() {
        router.toEdit()
    }

    func selectSetting(at section: Int, index: Int) {
        let setting = Section.settings[section].option[index]
        router.toSelectedSetting(at: setting)
    }
}
