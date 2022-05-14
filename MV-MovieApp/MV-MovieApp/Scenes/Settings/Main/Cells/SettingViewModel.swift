//
//  SettingsViewModel.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 10.05.2022.
//

import Foundation
import UIKit.UIImage

struct Section {
    let title: String
    let option: [SettingOption]
    
    static var settings: [Section] = [
        Section(title: "Account",
                option: [
                    SettingOption(title: "Profile",
                                   icon: UIImage(named: "profile")),
                    SettingOption(title: "Change Password",
                                   icon: UIImage(named: "padlock")),
                ]),
        Section(title: "General",
                option: [
                    SettingOption(title: "Notification",
                                   icon: UIImage(named: "notification")),
                    SettingOption(title: "Language",
                                   icon:UIImage(named: "language")),
                    SettingOption(title: "Country",
                                   icon: UIImage(named: "country")),
                    SettingOption(title: "Clear Cache",
                                   icon: UIImage(named: "trash")),
                ]),
        Section(title: "More",
                option: [
                    SettingOption(title: "Legal And Policies",
                                   icon: UIImage(named: "policies")),
                    SettingOption(title: "Help & Feedbacks",
                                   icon: UIImage(named: "help")),
                    SettingOption(title: "About Us",
                                   icon: UIImage(named: "info")),
                ])
    ]
}

struct SettingOption {
    let title: String
    let icon: UIImage?
}
