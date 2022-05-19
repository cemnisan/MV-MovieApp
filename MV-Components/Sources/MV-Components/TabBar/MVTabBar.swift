//
//  File.swift
//  
//
//  Created by Cem Nisan on 9.05.2022.
//

import UIKit

public final class MVTabBar: UITabBarController {
    
    private var homeVC: UIViewController!
    private var searchVC: UIViewController?
    private var bookMarkVC: UIViewController?
    private var profileVC: UIViewController?
    
    public init(homeVC: UIViewController,
                searchVC: UIViewController,
                bookMarkVC: UIViewController,
                profileVC: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        
        self.homeVC     = homeVC
        self.searchVC   = searchVC
        self.bookMarkVC = bookMarkVC
        self.profileVC  = profileVC
        
        viewControllers = [homeVC, searchVC, profileVC]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

extension MVTabBar {
    
    private func configure() {
        UITabBar.appearance().tintColor               = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 0.897328198, green: 0.8975278139, blue: 0.901071012, alpha: 0.8470095199)
        
        tabBar.backgroundColor = #colorLiteral(red: 0.1202597097, green: 0.1102947071, blue: 0.174954325, alpha: 1)
    }
}
