//
//  Validation.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import Foundation

enum Validation {
    /**
    
        - Password: Minimum 8 characters at least 1 Alphabet and 1 Number:
        - Username: username is 3-20 characters long,
                    no _ or . at the beginning,
                    no __ or _. or ._ or .. inside,
                    no _ or . at the end,
                    allowed characters [a-zA-Z]
     */
    static let emailRegex                  = NSRegularExpression("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    static let passwordRegex               = NSRegularExpression("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")
    static let usernameRegex               = NSRegularExpression("^(?=.{3,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$")
    
    /// Login/Register Validation
    /// - Parameters:
    ///   - username: If user on the register screen, username is not nil, validate it.
    ///   - email: Validate email
    ///   - password: Validate Password
    static func validate(username: String? = nil,
                         email: String,
                         password: String) throws {
        if let username = username {
            guard !username.isEmpty else { throw ValidationError.emptyUsername }
            guard usernameRegex.matches(username) else { throw ValidationError.invalidUsername }
        }
        
        guard !email.isEmpty else { throw ValidationError.emptyEmail }
        guard emailRegex.matches(email) else { throw ValidationError.invalidEmail}
        
        guard !password.isEmpty else { throw ValidationError.emptyPassword }
        guard passwordRegex.matches(password) else { throw ValidationError.invalidPassword }
    }
}
