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
        image: UIImage,
        imageData: Data)
    {
        DispatchQueue.main.async {
            if picker.title == "profilePic" {
                self.view.showChosenProfilePic(chosenImage: image)
                self.uploadImage(selectedPicker: .profilePic, image: imageData)
            } else {
                self.view.showChosenBackgroundPic(chosenImage: image)
                self.uploadImage(selectedPicker: .backgroundPic, image: imageData)
            }
        }
    }
    
    func uploadImage(selectedPicker:SelectPickerView,
                     image: Data) {
        interactor.uploadImage(selectedPicker: selectedPicker, image: image)
    }
    
    func isTextFieldsChanged(
        for usernameText: String,
        fullNameText: String) -> Bool
    {
        if
            currentUsername != usernameText ||
            currentFullName != fullNameText
        {
            return true
        }
        else { return false }
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

    func showUpdatedImage(with url: String,
                          selectedPicker: SelectPickerView) {
        
        switch selectedPicker {
        case .profilePic:
            view.showUpdatedImage(profileUrl: url, backgroundUrl: nil)
        case .backgroundPic:
            view.showUpdatedImage(profileUrl: nil, backgroundUrl: url)
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
