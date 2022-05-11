//
//  ProfileEditContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 11.05.2022.
//

import Foundation

protocol ProfileEditInteractorProtocol: AnyObject {
    var delegate: ProfileEditInteractorOutput? { get set }
    
    func loadCurrentUser()
}

protocol ProfileEditInteractorOutput: AnyObject {
    func showCurrentUser(currentUser: UserPresentation)
}

protocol ProfileEditPresenterProtocol: AnyObject {
    func loadCurrentUser()
}

protocol ProfileEditPresenterOutput: AnyObject {
    func showCurrentUser(currentUser: UserPresentation)
}

protocol ProfileEditRouter {}
