//
//  RegisterService.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import Foundation

protocol RegisterService: BaseAuthenticateService {
    func register(with username: String,
                  email: String,
                  password: String,
                  completed: @escaping (Result<UserPresentation, Error>) -> Void)
}
