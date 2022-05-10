//
//  AppData.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 9.05.2022.
//

import Foundation

struct AppData {
    @Storage(key: "enable_auto_login", defaultValue: false)
    static var enableAutoLogin: Bool
    
    @Storage(key: "username", defaultValue: "")
    static var userName: String
}
