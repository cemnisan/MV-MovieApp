//
//  FavoritesBuilder.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import UIKit.UIViewController

final class FavoritesBuilder {
    
    static func make() -> UIViewController {
        let rootView        = FavoritesViewController()
        rootView.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        
        return rootView
    }
}
