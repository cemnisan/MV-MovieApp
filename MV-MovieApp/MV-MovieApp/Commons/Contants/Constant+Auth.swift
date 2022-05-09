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
        static let nameLabel                   = "Name"
        static let nameTextField               = "Enter your name"
        static let emailLabel                  = "Email"
        static let emailTextField              = "Enter your email"
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
