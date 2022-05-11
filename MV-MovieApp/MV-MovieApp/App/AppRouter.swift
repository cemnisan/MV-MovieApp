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
        let rootNavigationController: UIViewController
        
        switch AppData.enableAutoLogin {
        case true:
            rootNavigationController = TabBar.createTabBar()
        case false:
            rootNavigationController = LoginBuilder.make()
        }
        
        window.windowScene           = windowScene
        window.rootViewController    = rootNavigationController
        window.makeKeyAndVisible()
    }
}
