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

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Config.accessToken = K.API.apiKey
        FirebaseApp.configure()
        
        return true
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
