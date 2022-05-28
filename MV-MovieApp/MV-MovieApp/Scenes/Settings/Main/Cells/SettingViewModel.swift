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
    
    static let settings: [Section] = [
        Section(title: K.Settings.accountSection,
                option: [
                    SettingOption(title: K.Settings.profileTitle,
                                  icon: K.Settings.profileImage),
                    SettingOption(title: K.Settings.changePasswordTitle,
                                  icon: K.Settings.changePassowordImage),
                ]),
        Section(title: K.Settings.generalSection,
                option: [
                    SettingOption(title: K.Settings.notificationTitle,
                                  icon: K.Settings.notificationImage),
                    SettingOption(title: K.Settings.languageTitle,
                                  icon: K.Settings.languageImage),
                    SettingOption(title: K.Settings.countryTitle,
                                  icon: K.Settings.countryImage),
                    SettingOption(title: K.Settings.clearCacheTitle,
                                  icon: K.Settings.clearCacheImage),
                ]),
        Section(title: K.Settings.moreSection,
                option: [
                    SettingOption(title: K.Settings.policiesTitle,
                                  icon: K.Settings.policiesImage),
                    SettingOption(title: K.Settings.helpTitle,
                                  icon: K.Settings.helpImage),
                    SettingOption(title: K.Settings.aboutTitle,
                                  icon: K.Settings.aboutImage),
                ])
    ]
}

struct SettingOption {
    let title: String
    let icon: UIImage?
}
