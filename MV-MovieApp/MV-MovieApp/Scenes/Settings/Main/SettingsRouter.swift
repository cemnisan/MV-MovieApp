//
//  SettingsRouter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 10.05.2022.
//

import UIKit

final class SettingsRouter {
    
    unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension SettingsRouter: SettingsRoute {
    
    func toLogin() {
        let targetView = LoginBuilder.make()
        targetView.modalTransitionStyle   = .coverVertical
        targetView.modalPresentationStyle = .fullScreen
        view.show(targetView, sender: nil)
    }
    
    func toEdit(with currentUser: UserPresentation) {
        let targetView = ProfileEditBuilder.make(with: currentUser)
        view.navigationController?.pushViewController(targetView, animated: true)
    }
    
    func toSelectedSetting(_ setting: SettingOption) {
        let targetView: UIViewController
        
        switch setting.title {
        case "Member": break
        case "Change Password":
            targetView = ChangePasswordBuilder.make()
            view.navigationController?.pushViewController(targetView, animated: true)
            
        case "Notification":
            targetView = NotificationBuilder.make()
            view.navigationController?.pushViewController(targetView, animated: true)
            
        case "Language":
            targetView = LanguageBuilder.make()
            view.navigationController?.pushViewController(targetView, animated: true)
            
        case "Country":
            targetView = CountryBuilder.make()
            view.navigationController?.pushViewController(targetView, animated: true)
            
        case "Clear Cache":
            targetView = ClearCacheBuilder.make()
            view.navigationController?.pushViewController(targetView, animated: true)
            
        case "Legal And Policies":
            targetView = LegalPoliciesBuilder.make()
            view.navigationController?.pushViewController(targetView, animated: true)
            
        case "Help & Feedbacks":
            targetView = FeedbacksBuilder.make()
            view.navigationController?.pushViewController(targetView, animated: true)
            
        case "About Us":
            targetView = AboutBuilder.make()
            view.navigationController?.pushViewController(targetView, animated: true)
        default: break
        }
    }
}
