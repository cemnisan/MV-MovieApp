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
    func updateUser(with fullName: String?,
                    username: String?,
                    profilePic: String?,
                    completion: @escaping (Result<UserPresentation, Error>) -> Void)
    func isUserAlreadyExist(registeredUser: UserPresentation, completion: @escaping (Bool) -> Void)
    func isUsernameAlreadyExist(username: String?, completion: @escaping (Bool) -> Void)
}
