//
//  RegisterBuilder.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit

final class RegisterBuilder {
    
    static func make() -> RegisterViewController {
        let viewController = RegisterViewController()
        let interactor     = RegisterInteractor()
        let router         = RegisterRouter(view: viewController)
        let presenter      = RegisterPresenter(view: viewController,
                                             interactor: interactor,
                                             router: router)
        viewController.registerPresenter = presenter
        
        return viewController
    }
}
