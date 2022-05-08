//
//  SignUpRouter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 2.05.2022.
//

import UIKit

final class RegisterRouter {
    
    unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension RegisterRouter: RegisterRoute {
    func toHome() {
        let homeView = HomeBuilder.make()
        homeView.modalPresentationStyle = .fullScreen
        homeView.modalTransitionStyle   = .crossDissolve
        view.show(homeView, sender: nil)
    }
}
