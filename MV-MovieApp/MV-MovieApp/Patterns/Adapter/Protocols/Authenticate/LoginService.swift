//
//  LoginService.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import Foundation
import UIKit.UIViewController

protocol LoginService: BaseAuthenticateService {
    func login(with email: String,
               password: String,
               completion: @escaping (Result<UserPresentation, Error>) -> Void)
}
