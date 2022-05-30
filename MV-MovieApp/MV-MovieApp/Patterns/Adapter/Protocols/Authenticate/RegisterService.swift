//
//  RegisterService.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import Foundation
import enum MovieDB_Wrapper.Result

protocol RegisterService: BaseAuthenticateService {
    func register(with username: String,
                  email: String,
                  password: String,
                  completion: @escaping (Result<UserPresentation>) -> Void)
}
