//
//  AuthenticationService.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import Foundation
import UIKit.UIViewController

protocol AuthenticationService {
    func loginWithGoogle(presenterViewController presenter: UIViewController,
                         completed: @escaping (Result<UserPresentation, Error>) -> Void)
}
