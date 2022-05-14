//
//  SettingsBuilder.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import UIKit.UIViewController

final class SettingsBuilder {
    
    static func make() -> UIViewController {
        let rootView        = SettingsViewController()
        let interactor      = SettingsInteractor(
            userService: GoogleAuthenticatorAdapter(),
            fireStoreService: GoogleFireStoreAdapter())
        let router          = SettingsRouter(view: rootView)
        let presenter       = SettingsPresenter(
            interactor: interactor,
            router: router,
            view: rootView)
        rootView.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 3)
        rootView.settingsPresenter = presenter
        
        return rootView
    }
}
