//
//  ProfileBuilder.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 13.05.2022.
//

import UIKit

final class ProfileBuilder {
    static func make() -> UINavigationController {
        let view = ProfileViewController()
        let interactor = ProfileInteractor(fireStoreService: GoogleFireStoreAdapter())
        let router     = ProfileRouter(view: view)
        let presenter  = ProfilePresenter(
            view: view,
            interactor: interactor,
            router: router)
        view.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        view.profilePresenter = presenter
        
        return UINavigationController(rootViewController: view)
    }
}
