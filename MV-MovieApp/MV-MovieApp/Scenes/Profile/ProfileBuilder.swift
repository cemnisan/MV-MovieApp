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
        view.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "profile"),
            selectedImage: nil)
        view.tabBarItem.imageInsets = UIEdgeInsets(
            top: 0,
            left: -10,
            bottom: -6,
            right: -10)
        view.profilePresenter = presenter
        
        return UINavigationController(rootViewController: view)
    }
}
