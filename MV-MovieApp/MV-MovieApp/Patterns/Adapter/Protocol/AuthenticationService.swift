//
//  AuthenticationService.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import Foundation
import UIKit.UIViewController

protocol AuthenticationService {
    func login(presenterViewController presenter: UIViewController,
               completed: @escaping (Result<UserPresentation, Error>) -> Void)
    func login(with email: String,
               password: String,
               completed: @escaping (Result<UserPresentation, Error>) -> Void)
    func register(with username: String,
                  email: String,
                  password: String,
                  completed: @escaping (Result<UserPresentation, Error>) -> Void)
}
