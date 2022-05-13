//
//  Validation.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import Foundation

enum Validation {
    static let emailRegex    = NSRegularExpression("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    static let passwordRegex = NSRegularExpression("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")
    static let usernameRegex = NSRegularExpression("^(?=.{3,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$")
    
    /// Login/Register Validation
    /// - Parameters:
    ///   - username: If user on the register screen, username is not nil, validate it.
    ///   - email: Validate email
    ///   - password: Validate Password
    static func validate(username: String? = nil,
                         email: String?    = nil,
                         password: String? = nil) throws {
        if let username = username {
            guard !username.isEmpty else { throw ValidationError.emptyUsername }
            guard usernameRegex.matches(username) else { throw ValidationError.invalidUsername(username: username) }
        }
        
        if let email = email {
            guard !email.isEmpty else { throw ValidationError.emptyEmail }
            guard emailRegex.matches(email) else { throw ValidationError.invalidEmail}
        }
        
        if let password = password {
            guard !password.isEmpty else { throw ValidationError.emptyPassword }
            guard passwordRegex.matches(password) else { throw ValidationError.invalidPassword }
        }
    }
}
