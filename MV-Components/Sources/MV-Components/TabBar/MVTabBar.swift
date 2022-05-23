//
//  File.swift
//  
//
//  Created by Cem Nisan on 9.05.2022.
//

import UIKit

public final class MVTabBar: UITabBarController {
    
    private var homeVC: UIViewController!
    private var searchVC: UIViewController!
    private var profileVC: UIViewController!
    
    public init(homeVC: UIViewController,
                searchVC: UIViewController,
                profileVC: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        
        self.homeVC     = homeVC
        self.searchVC   = searchVC
        self.profileVC  = profileVC
        
        viewControllers = [homeVC, searchVC, profileVC]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
