//
//  ValidationError.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import Foundation

extension ValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptyUsername:
            return "Empty username"
        case .invalidUsername(let username):
            return "Invalid \(username), please change it."
        case .alreadyExistUsername(username: let username):
            return "This \(username) is already exist. Please change it."
        case .emptyEmail:
            return "Empty Email"
        case .invalidEmail:
            return "Invalid Email"
        case .emptyPassword:
            return "Empty Password"
        case .invalidPassword:
            return "Invalid Password"
        }
    }
}
