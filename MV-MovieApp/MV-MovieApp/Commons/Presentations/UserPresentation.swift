//
//  UserPresentation.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 6.05.2022.
//

import Foundation

struct UserPresentation {
    var username: String?
    var email: String
    var imageURL: URL
    
    init(username: String?,
         email: String,
         imageURL: URL) {
        self.username = username
        self.email    = email
        self.imageURL = imageURL
    }
}
