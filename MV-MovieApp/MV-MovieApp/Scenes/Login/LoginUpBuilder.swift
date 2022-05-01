//
//  LoginUpBuilder.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit

final class LoginUpBuilder {
    
    static func make() -> UINavigationController {
        let viewController = LoginUpViewController()
        
        return UINavigationController(rootViewController: viewController)
    }
}
