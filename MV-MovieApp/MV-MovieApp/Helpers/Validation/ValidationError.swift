//
//  ValidationError.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import Foundation

enum ValidationError: Error {
    case emptyUsername
    case invalidUsername
    case emptyEmail
    case invalidEmail
    case emptyPassword
    case invalidPassword
}
