//
//  SignUpBuilder.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit

final class SignUpBuilder {
    
    static func make() -> UINavigationController {
        let viewController = SignUpViewController()
        
        return UINavigationController(rootViewController: viewController)
    }
}
