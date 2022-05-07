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
        static let backgroundColor             = #colorLiteral(red: 0.1202597097, green: 0.1102947071, blue: 0.174954325, alpha: 1)
        static let globalColor                 = #colorLiteral(red: 0.6117647059, green: 0.6117647059, blue: 0.6117647059, alpha: 1)
        static let childViewsColor             = #colorLiteral(red: 0.2078431373, green: 0.2039215686, blue: 0.2509803922, alpha: 1)
        static let actionButtonColor           = #colorLiteral(red: 0.6673278213, green: 0.4603560567, blue: 0.3788063228, alpha: 1)
        static let labelTextColor: UIColor     = .white
        static let navTitleColor: [NSAttributedString.Key: UIColor] = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
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
