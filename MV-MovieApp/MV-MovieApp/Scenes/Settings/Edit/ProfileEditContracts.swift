//
//  ProfileEditContracts.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 11.05.2022.
//

import UIKit
import PhotosUI

// MARK: - Interactor Protocol
protocol ProfileEditInteractorProtocol: AnyObject {
    var delegate: ProfileEditInteractorOutput? { get set }
    
    func loadCurrentUser()
    
    func uploadPicture(selectedPicker: SelectPickerView, image: Data)
    func updateUser(with fullName: String, username: String)
}

// MARK: - Interactor Output
protocol ProfileEditInteractorOutput: AnyObject {
    
    func initializeProgress(progress: Float?)
    
    func showUpdatedPicture(with url: String, selectedPicker: SelectPickerView)
    func showCurrentUser(currentUser: UserPresentation)
    func showError(error: Error)
    
    func displayLoading()
    func dismissLoading()
}

// MARK: - Presenter Protocol
protocol ProfileEditPresenterProtocol: AnyObject {
    var currentFullName: String! { get }
    var currentUsername: String! { get }
    
    func loadCurrentUser()
    
    func choosePictureButtonTapped(
        on selectedPickerView: SelectPickerView,
        delegate: ProfileEditViewController)
    
    func chosenPicture(
        on picker: PHPickerViewController,
        picture: UIImage,
        pictureData: Data)
    
    func isTextFieldsChanged(
        for usernameText: String,
        fullNameText: String) -> Bool
    
    func updateUser(
        with fullName: String,
        username: String)
}

// MARK: - Presenter Output
protocol ProfileEditPresenterOutput: AnyObject {
    
    func showCurrentUser(currentUser: UserPresentation)
    func showStartedProgress(progress: Float)
    func showChosenPictures(chosenProfilePic: UIImage?, chosenBackgroundPic: UIImage?)
    func showUpdatedPictures(profileUrl: String?, backgroundUrl: String?)
    func showError(error: Error)
    
    func displayLoading()
    func dismissLoading()
}

// MARK: - Router
protocol ProfileEditRoute {
    func toPickerView(pickerView selectedPickerView: SelectPickerView,
                      delegate: ProfileEditViewController)
}
