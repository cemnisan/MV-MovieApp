//
//  Constant+Settings.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 28.05.2022.
//

import UIKit

extension K {
    struct Settings {
        static let navTitle             = "Settings"
        static let logOutTitle          = "Log out"
        static let infoAlertBody        = "When you did tapped on log out button, you are going to login page.\nAre you sure?"
        
        static let accountSection       = "Account"
        static let profileTitle         = "Profile"
        static let profileImage         = UIImage(named: "profile")
        static let changePasswordTitle  = "Change Password"
        static let changePassowordImage = UIImage(named: "padlock")
        
        static let generalSection       = "General"
        static let notificationTitle    = "Notification"
        static let notificationImage    = UIImage(named: "notification")
        static let languageTitle        = "Language"
        static let languageImage        = UIImage(named: "language")
        static let countryTitle         = "Country"
        static let countryImage         = UIImage(named: "country")
        static let clearCacheTitle      = "Clear Cache"
        static let clearCacheImage      = UIImage(named: "trash")
        
        static let moreSection          = "More"
        static let policiesTitle        = "Legal And Policies"
        static let policiesImage        = UIImage(named: "policies")
        static let helpTitle            = "Help & Feedbacks"
        static let helpImage            = UIImage(named: "help")
        static let aboutTitle           = "About Us"
        static let aboutImage           = UIImage(named: "info")
        
        static let userEditButton       = UIImage(named: "edit")!
    }
}
