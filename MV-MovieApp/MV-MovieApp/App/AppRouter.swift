//
//  AppRouter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import UIKit

final class AppRouter {
    let window: UIWindow
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
}

extension AppRouter {
    
    func start(with windowScene: UIWindowScene) {
        let isLoggin = false
        var rootNavigationController: UIViewController!
        
        switch isLoggin {
        case true:
            rootNavigationController = createTabBar()
        case false:
            rootNavigationController = LoginBuilder.make()
        }
        
        window.windowScene           = windowScene
        window.rootViewController    = rootNavigationController
        window.makeKeyAndVisible()
    }
    
    private func createTabBar() -> UITabBarController {
        let tabBar                                    = UITabBarController()
        
        UITabBar.appearance().tintColor               = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 0.897328198, green: 0.8975278139, blue: 0.901071012, alpha: 0.8470095199)
    
        tabBar.tabBar.backgroundColor                 = #colorLiteral(red: 0.1887327433, green: 0.178624779, blue: 0.2303351164, alpha: 1)
        tabBar.viewControllers                        = [HomeBuilder.make(),
                                                         SearchBuilder.make(),
                                                         FavoritesBuilder.make(),
                                                         ProfileBuilder.make()]
        return tabBar
    }
}
