//
//  ProfileEditContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 11.05.2022.
//

import Foundation

// MARK: - Interactor Protocol
protocol ProfileEditInteractorProtocol: AnyObject {
    var delegate: ProfileEditInteractorOutput? { get set }
    
    func loadCurrentUser()
    func uploadImage(image: Data)
    func updateUser(with fullName: String,
                    username: String,
                    email: String)
}

// MARK: - Interactor Output
protocol ProfileEditInteractorOutput: AnyObject {
    func showCurrentUser(currentUser: UserPresentation)
    func initializeProgress(progress: Float?)
    func showUpdatedImage(with url: String)
    func showError(error: Error)
    
    func displayLoading()
    func dismissLoading()
}

// MARK: - Presenter Protocol
protocol ProfileEditPresenterProtocol: AnyObject {
    func loadCurrentUser()
    func uploadImage(image: Data)
    func updateUser(with fullName: String,
                    username: String,
                    email: String)
}

// MARK: - Presenter Output
protocol ProfileEditPresenterOutput: AnyObject {
    func showCurrentUser(currentUser: UserPresentation)
    func initializeProgress(progress: Float?)
    func showUpdatedImage(with url: String)
    func showError(error: Error)

    func displayLoading()
    func dismissLoading()
}

// MARK: - Router
protocol ProfileEditRouter {}
