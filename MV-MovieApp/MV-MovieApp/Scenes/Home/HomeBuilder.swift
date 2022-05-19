//
//  HomeBuilder.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import UIKit
import MovieDB_Wrapper

final class HomeBuilder {
    
    static func make() -> UINavigationController {
        let router                   = HomeRouter()
        let interactor               = HomeInteractor(
            moviesService: MovieService()w,
            genresService: GenresService())
        let viewController           = HomeViewController()
        let presenter                = HomePresenter(
            view: viewController,
            interactor: interactor,
            router: router)
        viewController.tabBarItem    = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        viewController.homePresenter = presenter
        
        return UINavigationController(rootViewController: viewController)
    }
}
