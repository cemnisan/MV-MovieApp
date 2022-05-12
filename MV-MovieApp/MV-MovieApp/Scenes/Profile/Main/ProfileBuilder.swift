//
//  ProfileBuilder.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import UIKit.UIViewController

final class ProfileBuilder {
    
    static func make() -> UINavigationController {
        let rootView        = ProfileViewController()
        let interactor      = ProfileInteractor(userService: GoogleAuthenticatorAdapter(),
                                                fireStoreService: GoogleFireStoreAdapter())
        let router          = ProfileRouter(view: rootView)
        let presenter       = ProfilePresenter(interactor: interactor,
                                               router: router,
                                               view: rootView)
        rootView.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 3)
        rootView.profilePresenter = presenter
        
        return UINavigationController(rootViewController: rootView)
    }
}
