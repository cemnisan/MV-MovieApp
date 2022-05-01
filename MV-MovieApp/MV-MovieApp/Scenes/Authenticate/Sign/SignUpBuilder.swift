//
//  SignUpBuilder.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit

final class SignUpBuilder {
    
    static func make() -> SignUpViewController {
        let viewController = SignUpViewController()
        let interactor     = SignUpInteractor()
        let router         = SignUpRouter(view: viewController)
        let presenter      = SignUpPresenter(view: viewController,
                                             interactor: interactor,
                                             router: router)
        viewController.signUpPresenter = presenter
        
        return viewController
    }
}
