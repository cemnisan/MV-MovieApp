//
//  Constant+Firebase.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 28.05.2022.
//

import Foundation

extension K {
    struct Firebase {
        static let userCollection  = "users"
        static let idField         = "id"
        static let usernameField   = "username"
        
        static let dataContentType = "image/jpeg"
        static let userChild       = "User"
        
        static let charset         = "0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._"
    }
}
