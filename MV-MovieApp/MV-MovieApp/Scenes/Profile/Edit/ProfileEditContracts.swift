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
    func uploadImage(image: Data)
    func updateUser(with image: Data,
                    fullName: String,
                    username: String)
}

protocol ProfileEditInteractorOutput: AnyObject {
    func showCurrentUser(currentUser: UserPresentation)
    func showUpdatedImage(with url: URL)
    
    func displayLoading()
    func dismissLoading()
}

protocol ProfileEditPresenterProtocol: AnyObject {
    func loadCurrentUser()
    func uploadImage(image: Data)
    func updateUser(with image: Data,
                    fullName: String,
                    username: String)
}

protocol ProfileEditPresenterOutput: AnyObject {
    func showCurrentUser(currentUser: UserPresentation)
    func showUpdatedImage(with url: URL)
    
    func displayLoading()
    func dismissLoading()
}

protocol ProfileEditRouter {}
