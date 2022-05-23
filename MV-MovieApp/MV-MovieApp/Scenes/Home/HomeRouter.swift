//
//  HomeRouter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import UIKit

final class HomeRouter: HomeRoute {
    
    private unowned var view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension HomeRouter {
    
    func toDetail() {
        let targetView = MovieDetailsBuilder.make()
        view.navigationController?.pushViewController(targetView, animated: true)
    }
}
