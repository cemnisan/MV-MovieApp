//
//  GoogleFireStoreService.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 12.05.2022.
//

import Foundation

protocol GoogleFireStoreService {
    func createUser(user: UserPresentation)
    func readCurrentUser(completion: @escaping (Result<UserPresentation, Error>) -> Void)
    func updateUser(user: UserPresentation,
                    completion: @escaping (Result<UserPresentation, Error>) -> Void)
    func isUserAlreadyExist(registeredUser: UserPresentation, completion: @escaping (Bool) -> Void)
}
