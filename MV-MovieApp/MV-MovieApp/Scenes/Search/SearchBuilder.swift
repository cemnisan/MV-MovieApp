//
//  SearchBuilder.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import UIKit.UIViewController

final class SearchBuilder {
    
    static func make() -> UIViewController {
        let rootView        = SearchViewController()
        rootView.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        return rootView
    }
}
