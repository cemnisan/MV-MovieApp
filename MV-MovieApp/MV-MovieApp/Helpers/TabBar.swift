//
//  CreateTabBar.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 9.05.2022.
//

import UIKit
import class MV_Components.MVTabBar

struct TabBar {
    static func createTabBar() -> UITabBarController {
        let homeViewController      = HomeBuilder.make()
        let searchViewController    = SearchBuilder.make()
        let favoritesViewController = FavoritesBuilder.make()
        let profileViewController   = ProfileBuilder.make()
        
        let tabBar = MVTabBar(homeVC: homeViewController,
                              searchVC: searchViewController,
                              bookMarkVC: favoritesViewController,
                              profileVC: profileViewController)
        return tabBar
    }
}
