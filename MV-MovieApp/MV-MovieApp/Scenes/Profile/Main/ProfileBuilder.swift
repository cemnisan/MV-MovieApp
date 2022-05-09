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
        rootView.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 3)
        
        return UINavigationController(rootViewController: rootView)
    }
}
