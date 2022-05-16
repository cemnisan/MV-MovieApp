//
//  ProfileContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 13.05.2022.
//

import Foundation

// MARK: - Interactor Protocol
protocol ProfileInteractorProtocol: AnyObject {
    var delegate: ProfileInteractorOutput? { get set }
    
    func loadCurrentUser()
}

// MARK: - Interactor Output
protocol ProfileInteractorOutput: AnyObject {
    func showCurrentUser(currentUser: UserPresentation)
}

// MARK: - Presenter Protocol
protocol ProfilePresenterProtocol: AnyObject {
    
    func loadCurrentUser()
    
    func editProfileTapped()
}

// MARK: - Presenter Output
protocol ProfilePresenterOutput: AnyObject {
    func showCurrentUser(currentUser: UserPresentation)
}

// MARK: - Router
protocol ProfileRoute: AnyObject {
    func toEditProfile()
}
