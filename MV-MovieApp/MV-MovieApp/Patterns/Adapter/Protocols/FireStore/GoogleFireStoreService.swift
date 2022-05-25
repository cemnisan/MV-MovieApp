//
//  GoogleFireStoreService.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 12.05.2022.
//

import Foundation

protocol GoogleFireStoreService {
    func createUser(user: UserPresentation)
    func readUser(completion: @escaping (Result<UserPresentation, Error>) -> Void)
    func updateUser(
        with fullName: String?,
        username: String?,
        profilePic: String?,
        backgroundPic: String?,
        completion: @escaping (Result<UserPresentation, Error>) -> Void)
    func saveLoggedInUserIfNeeded(loggedInUser: UserPresentation)
    func isUsernameAlreadyExist(username: String?, completion: @escaping (Bool) -> Void)
}
