//
//  BaseAuthenticateRouter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 9.05.2022.
//

import UIKit

class BaseAuthenticateRouter {
    
    unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension BaseAuthenticateRouter:BaseAuthenticateRoute {
    
    func toHome() {
        let homeView            = TabBar.createTabBar()
        view.show(homeView, sender: nil)
    }
}
