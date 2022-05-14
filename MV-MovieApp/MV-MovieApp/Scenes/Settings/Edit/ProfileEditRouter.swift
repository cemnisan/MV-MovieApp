//
//  ProfileEditRoute.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 11.05.2022.
//

import UIKit
import PhotosUI

final class ProfileEditRouter {
    
    private unowned var view: UIViewController!
    private var profilePicker: PHPickerViewController!
    private var backgroundPicker: PHPickerViewController!
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension ProfileEditRouter: ProfileEditRoute {
    
    func toPickerView(pickerView selectedPickerView: SelectPickerView,
                      delegate: ProfileEditViewController) {
        var config            = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter         = PHPickerFilter.images
        
        switch selectedPickerView {
        case .profilePic:
            profilePicker          = PHPickerViewController(configuration: config)
            profilePicker.title    = "profilePic"
            profilePicker.delegate = delegate
            view.present(profilePicker, animated: true)
        case .backgroundPic:
            backgroundPicker          = PHPickerViewController(configuration: config)
            backgroundPicker.title    = "backgroundPic"
            backgroundPicker.delegate = delegate
            view.present(backgroundPicker, animated: true)
        }
    }
}
