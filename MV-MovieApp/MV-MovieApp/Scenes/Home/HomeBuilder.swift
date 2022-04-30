//
//  HomeBuilder.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import UIKit

final class HomeBuilder {
    
    static func make() -> UINavigationController {
        let router = HomeRouter()
        let interactor = HomeInteractor(moviesService: app.service)
        let viewController = HomeViewController()
        let presenter  = HomePresenter(view: viewController,
                                       interactor: interactor,
                                       router: router)
        viewController.homePresenter = presenter
        
        return UINavigationController(rootViewController: viewController)
    }
}
