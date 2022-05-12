//
//  UserService.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 10.05.2022.
//

import Foundation

protocol UserService {
    func signOut(completed: @escaping () -> Void,
                 failure: @escaping (Error) -> Void)
}
