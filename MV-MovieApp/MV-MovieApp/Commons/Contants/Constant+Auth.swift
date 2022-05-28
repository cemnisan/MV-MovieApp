//
//  Constants+Auth.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 8.05.2022.
//

import Foundation
import UIKit

extension K {
    struct Auth {
        static let dummyName                   = "Anonymous"
        static let unavailableEmail            = "Email is unavailable"
        static let dummyProfilePic             = "https://dummyimage.com/120x120/000/0011ff.png"
        static let dummyBackgroundPic          = "https://dummyimage.com/600x300/000/fff"
        
        static let userNameLabel               = "Username"
        static let userNamePlaceHolder         = "Enter your username"
        static let fullNameLabel               = "Full Name"
        static let fullNamePlaceholder         = "Enter your Full Name"
        static let emailLabel                  = "Email"
        static let emailPlaceholder            = "Enter your email"
        static let passwordLabel               = "Password"
        static let passwordTextField           = "Enter your password"
                
        static let loginNavTitle               = "Login"
        static let loginScreenTitle            = "Log in with one of following options"
        static let loginAccountLabel           = "Don’t have an account?"
        static let loginActionButton           = "Log in"
        static let loginAccountActionButton    = "Sign Up"
        
        static let registerNavTitle            = "Register"
        static let registerScreenTitle         = "Sign up with one of following options"
        static let registerAccountLabel        = "Already have an account"
        static let registerActionButton        = "Create Account"
        static let registerAccountActionButton = "Log in"
       
        static let appleViewImage              = UIImage(named: "apple")
        static let googleViewImage             = UIImage(named: "google")
            
        static let passwordVisible             = UIImage(systemName: "eye.fill")
        static let passwordInvisible           = UIImage(systemName: "eye.slash.fill")
    }
}
