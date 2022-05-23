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
        let view       = HomeViewController()
        let interactor = HomeInteractor(
            moviesService: MovieService(),
            genresService: GenresService(),
            fireStoreService: GoogleFireStoreAdapter())
        let router     = HomeRouter(view: view)
        let presenter  = HomePresenter(
            view: view,
            interactor: interactor,
            router: router)
        
        view.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(named: "home"),
            selectedImage: nil)
        view.tabBarItem.imageInsets = UIEdgeInsets(
            top: 0,
            left: -10,
            bottom: -6,
            right: -10)
        view.homePresenter = presenter
        
        return UINavigationController(rootViewController: view)
    }
}
