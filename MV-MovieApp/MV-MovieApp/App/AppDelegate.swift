//
//  AppDelegate.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import UIKit
import struct MovieDB_Wrapper.Config
import Firebase
import GoogleSignIn
import Kingfisher

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        if #available(iOS 15, *) {
            configureNavBar()
            configureTabBar()
        }
        
        Config.accessToken = K.API.apiKey
        FirebaseApp.configure()
        configureKingfisherCache()
        
        return true
    }
    
    private func configureKingfisherCache() {
        let cache = ImageCache.default
        
        cache.memoryStorage.config.totalCostLimit = 1024 * 1024 * 10
        cache.diskStorage.config.sizeLimit        = 1024 * 1024 * 100
    }
    
    private func configureNavBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes       = K.Styles.navTitleColor
        navigationBarAppearance.largeTitleTextAttributes  = K.Styles.navTitleColor
        navigationBarAppearance.backgroundColor           = K.Styles.backgroundColor
    
        UINavigationBar.appearance().standardAppearance   = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance    = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UIBarButtonItem.appearance().tintColor            = .white
    }
    
    private func configureTabBar() {
        let tabBarApperance = UITabBarAppearance()
        tabBarApperance.configureWithOpaqueBackground()
        tabBarApperance.backgroundColor               = K.Styles.backgroundColor
        
        UITabBar.appearance().scrollEdgeAppearance    = tabBarApperance
        UITabBar.appearance().standardAppearance      = tabBarApperance
        UITabBar.appearance().tintColor               = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 0.897328198, green: 0.8975278139, blue: 0.901071012, alpha: 0.8470095199)
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration",
                                    sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}
