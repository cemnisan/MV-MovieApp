//
//  UserPresentation.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 6.05.2022.
//

import Foundation

struct UserPresentation: Codable {
    var fullName: String?
    var username: String?
    var email: String?
    var profilePic: String?
    var backgroundPic: String?
    var id: String?
    
    init(fullName: String?,
         username: String?,
         email: String?,
         profilePic: String?,
         backgroundPic: String?,
         id: String?) {
        self.fullName      = fullName
        self.username      = username
        self.email         = email
        self.profilePic    = profilePic
        self.backgroundPic = backgroundPic
        self.id            = id
    }
}
