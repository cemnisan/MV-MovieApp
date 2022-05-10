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
    let option: [SettingsOption]
    
    static var settings: [Section] = [
        Section(title: "Account",
                option: [
                    SettingsOption(title: "Member",
                                   icon: UIImage(named: "profile")),
                    SettingsOption(title: "Change Password",
                                   icon: UIImage(named: "padlock")),
                ]),
        Section(title: "General",
                option: [
                    SettingsOption(title: "Notification",
                                   icon: UIImage(named: "notification")),
                    SettingsOption(title: "Language",
                                   icon:UIImage(named: "language")),
                    SettingsOption(title: "Country",
                                   icon: UIImage(named: "country")),
                    SettingsOption(title: "Clear Cache",
                                   icon: UIImage(named: "trash")),
                ]),
        Section(title: "More",
                option: [
                    SettingsOption(title: "Legal And Policies",
                                   icon: UIImage(named: "policies")),
                    SettingsOption(title: "Help & Feedbacks",
                                   icon: UIImage(named: "help")),
                    SettingsOption(title: "About Us",
                                   icon: UIImage(named: "info")),
                ])
    ]
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
}
