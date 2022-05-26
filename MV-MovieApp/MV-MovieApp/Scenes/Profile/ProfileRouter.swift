//
//  ProfileRouter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 13.05.2022.
//

import UIKit

final class ProfileRouter {
    
    private unowned var view: UIViewController!
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension ProfileRouter: ProfileRoute {
    
    func toEditProfile() {
        let targetView = SettingsBuilder.make()
        view.navigationController?.pushViewController(targetView, animated: true)
    }
}
