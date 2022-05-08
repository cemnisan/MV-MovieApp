//
//  SignOutService.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import Foundation

protocol SignOutService {
    func signOut(completed: @escaping (Error?) -> Void)
}
