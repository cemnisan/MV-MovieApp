//
//  UserPresentation.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 6.05.2022.
//

import Foundation

struct UserPresentation {
    var fullName: String?
    var username: String?
    var email: String
    var imageURL: String?
    var id: String
    
    init(fullName: String?,
         username: String?,
         email: String,
         imageURL: String?,
         id: String) {
        self.fullName = fullName
        self.username = username
        self.email    = email
        self.imageURL = imageURL
        self.id       = id
    }
}
