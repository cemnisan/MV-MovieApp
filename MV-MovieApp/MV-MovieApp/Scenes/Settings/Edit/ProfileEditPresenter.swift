//
//  ProfileEditPresenter.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 11.05.2022.
//

import Foundation
import UIKit
import PhotosUI

final class ProfileEditPresenter {
    
    private unowned let view: ProfileEditPresenterOutput
    private let interactor: ProfileEditInteractorProtocol
    private let router: ProfileEditRoute
    
    private(set) var currentFullName: String!
    private(set) var currentUsername: String!
    
    init(interactor: ProfileEditInteractorProtocol,
         view: ProfileEditPresenterOutput,
         router: ProfileEditRoute) {
        self.interactor = interactor
        self.view       = view
        self.router     = router
        
        interactor.delegate = self
    }
}

// MARK: - Profile Edit Presenter Protocol
extension ProfileEditPresenter: ProfileEditPresenterProtocol {
 
    func loadCurrentUser() {
        interactor.loadCurrentUser()
    }
    
    func chosenPicture(
        on picker: PHPickerViewController,
        picture: UIImage,
        pictureData: Data)
    {
        DispatchQueue.main.async {
            if picker.title == "profilePic" {
                self.view.showChosenPictures(chosenProfilePic: picture, chosenBackgroundPic: nil)
                self.interactor.uploadPicture(selectedPicker: .profilePic, image: pictureData)
            } else {
                self.view.showChosenPictures(chosenProfilePic: nil, chosenBackgroundPic: picture)
                self.interactor.uploadPicture(selectedPicker: .backgroundPic, image: pictureData)
            }
        }
    }
 
    func isTextFieldsChanged(
        for usernameText: String,
        fullNameText: String) -> Bool
    {
        if currentUsername != usernameText || currentFullName != fullNameText {
            return true
        } else {
            return false
        }
    }
    
    func updateUser(with fullName: String,
                    username: String) {
        interactor.updateUser(with: fullName,
                              username: username)
    }
    
    func choosePictureButtonTapped(on selectedPickerView: SelectPickerView,
                                   delegate: ProfileEditViewController) {
        router.toPickerView(pickerView: selectedPickerView,
                            delegate: delegate)
    }
}

// MARK: - Profile Edit Interactor Output
extension ProfileEditPresenter: ProfileEditInteractorOutput {

    func showCurrentUser(currentUser: UserPresentation) {
        self.currentFullName = currentUser.fullName
        self.currentUsername = currentUser.username
        
        view.showCurrentUser(currentUser: currentUser)
    }
    
    func initializeProgress(progress: Float?) {
        if let progress = progress {
            view.showStartedProgress(progress: progress)
        }
    }

    func showUpdatedPicture(with url: String,
                          selectedPicker: SelectPickerView) {
        switch selectedPicker {
        case .profilePic:
            view.showUpdatedPictures(profileUrl: url, backgroundUrl: nil)
        case .backgroundPic:
            view.showUpdatedPictures(profileUrl: nil, backgroundUrl: url)
        }
    }
    
    func showError(error: Error) {
        view.showError(error: error)
    }
    
    func displayLoading() {
        view.displayLoading()
    }
    
    func dismissLoading() {
        view.dismissLoading()
    }
}
